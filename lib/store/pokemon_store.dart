import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:news_mobx/models/poke_api.dart';
import 'package:news_mobx/utils/consts.dart';
import 'package:http/http.dart' as http;

part 'pokemon_store.g.dart';

class PokemonStore = PokemonStoreBase with _$PokemonStore;

abstract class PokemonStoreBase with Store {
  @observable
  PokeApi pokeApi;
  
  @observable
  int length;

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
}
