import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex_mobx/models/poke_api.dart';
import 'package:pokedex_mobx/utils/consts.dart';
import 'package:http/http.dart' as http;

part 'pokemon_store.g.dart';

class PokemonStore = PokemonStoreBase with _$PokemonStore;

abstract class PokemonStoreBase with Store {
  @observable
  int posicaoLista = 0;

  @observable
  PokeApi pokeApi;
  
  @observable
  int length;

  @observable
  dynamic corPokemonAtual;

  @observable
  Pokemon pokemonAtual;

  @action
  Widget getThumb({String numero}) {
    return getImage(numero: numero);
  }

  @action
  fetchList() {
    loadPokeApi().then((pokeApiList) {
      pokeApi = pokeApiList;
      length = pokeApi.pokemon.length;
    });
  }

  @action 
  dynamic getColorPokemon({String type }) {
    return getColorType(type: type);  
  }

  @action
  setPosicaoLista({int index}) {
    if (index < 0) { 
      posicaoLista = 0;
    }
    else if (index > length - 1){
        posicaoLista = length;
    } 
    else {
      posicaoLista = index;  
    }
    pokemonAtual = pokeApi.pokemon[posicaoLista];
    corPokemonAtual = getColorType(type: pokemonAtual.type[0]);
  }

  Future<PokeApi> loadPokeApi() async {
    try {
      final response = await http.get(Consts.baseURL);
      var decodeJson = jsonDecode(response.body);
      return PokeApi.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Widget getImage({String numero}) {
    return CachedNetworkImage(
      placeholder: (context, url) => new Container(
        color: Colors.transparent,
      ),
      imageUrl:
          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
    );
  }

  Color getColorType({String type}) {
    switch (type) {
      case 'Normal':
        return Colors.brown[400];
        break;
      case 'Fire':
        return Colors.red;
        break;
      case 'Water':
        return Colors.blue;
        break;
      case 'Grass':
        return Colors.green;
        break;
      case 'Electric':
        return Colors.amber;
        break;
      case 'Ice':
        return Colors.cyanAccent[400];
        break;
      case 'Fighting':
        return Colors.orange;
        break;
      case 'Poison':
        return Colors.purple;
        break;
      case 'Ground':
        return Colors.orange[300];
        break;
      case 'Flying':
        return Colors.indigo[200];
        break;
      case 'Psychic':
        return Colors.pink;
        break;
      case 'Bug':
        return Colors.lightGreen[500];
        break;
      case 'Rock':
        return Colors.grey;
        break;
      case 'Ghost':
        return Colors.indigo[400];
        break;
      case 'Dark':
        return Colors.brown;
        break;
      case 'Dragon':
        return Colors.indigo[800];
        break;
      case 'Steel':
        return Colors.blueGrey;
        break;
      case 'Fairy':
        return Colors.pinkAccent[100];
        break;
      default:
        return Colors.grey;
        break;
    }
  }
}
