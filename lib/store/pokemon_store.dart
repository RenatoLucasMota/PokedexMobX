import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:news_mobx/models/poke_api.dart';
import 'package:news_mobx/utils/consts.dart';

part 'pokemon_store.g.dart';

class PokemonStore = PokemonStoreBase with _$PokemonStore;

abstract class PokemonStoreBase with Store {
  @observable
  PokeAPI pokeApi;

  @observable
  bool loadingList = false;

  @observable
  int length;

  @action
  fetchList() {
    loadPokeApi().then((pokeApiList) {
      pokeApi = pokeApiList;
      length = pokeApi.results.length;
    });
  }

  @action
  refreshList({String newURL}) {
    newPokeApi(newURL: newURL).then((pokeApiList) {
      loadingList = true;
      PokeAPI newPokeApi = pokeApiList;
      pokeApi.next = pokeApiList.next;
      pokeApi.count = pokeApiList.count;
      pokeApi.previous = pokeApiList.previous;
      pokeApi.results.addAll(newPokeApi.results);
      length = pokeApi.results.length;
      loadingList = false;
    });
  }

  Future<PokeAPI> loadPokeApi() async {
    try {
      final response = await Dio().get(Consts.baseURL).timeout(Duration(seconds: 2), onTimeout: () {
        newPokeApi();  
      } );  
      return PokeAPI.fromJson(response.data);
    }
    catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<PokeAPI> newPokeApi({String newURL}) async {
    try {
      final response = await Dio().get(newURL).timeout(Duration(seconds: 2), onTimeout: () {
        newPokeApi(newURL: newURL);  
      } );  
      return PokeAPI.fromJson(response.data);
    }
    catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
