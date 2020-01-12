import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:pokedex_mobx/models/evoluton.dart';
import 'package:pokedex_mobx/models/poke_apiv2.dart';
import 'package:pokedex_mobx/models/species.dart';
import 'package:pokedex_mobx/utils/consts.dart';
import 'package:http/http.dart' as http;

part 'pokemonv2_store.g.dart';

class PokemonV2Store = PokemonV2StoreBase with _$PokemonV2Store;

abstract class PokemonV2StoreBase with Store {
  @observable
  PokemonV2 pokemonV2;

  @observable
  Species species;

  @observable
  Evolucao evolucao;

  @action
  loadPokemon({String nome}) {
    pokemonV2 = null;
    Future.delayed(const Duration(milliseconds: 100), () {
      _loadPokemon(nome: nome).then((pokemon) {
        pokemonV2 = pokemon;
      });
    });
  }

  @action
  loadSpecie({int numero}) {
    species = null;
    Future.delayed(const Duration(milliseconds: 100), () {
      _loadSpecie(numero: numero + 1).then((specie) {
        species = specie;
        evolucao = null;
        _loadEvolucoes(url: species.evolutionChain.url).then((evolveto) {
            evolucao = evolveto;
        });
      });
    });
  }

  Future<PokemonV2> _loadPokemon({String nome}) async {
    try {
      if (nome.contains('Female')) {
        nome = 'nidoran-f';
      } else if (nome.contains('Male')) {
        nome = 'nidoran-m';
      }
      nome = nome.replaceAll('.', '-');
      nome = nome.replaceAll(' ', '');
      nome = nome.trim().toLowerCase();

      String url = Consts.urlPokemon + nome;
      final response = await http.get(url);
      var decodeJson = jsonDecode(response.body);
      return PokemonV2.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<Species> _loadSpecie({int numero}) async {
    try {
      String url = Consts.urlSpecis + numero.toString();
      final response = await http.get(url);
      var decodeJson = jsonDecode(response.body);
      return Species.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<Evolucao> _loadEvolucoes({String url}) async {
    try {
      final response = await http.get(url);
      var decodeJson = jsonDecode(response.body);
      return Evolucao.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
