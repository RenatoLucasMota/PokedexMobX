// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokemonStore on PokemonStoreBase, Store {
  final _$pokeApiAtom = Atom(name: 'PokemonStoreBase.pokeApi');

  @override
  PokeAPI get pokeApi {
    _$pokeApiAtom.context.enforceReadPolicy(_$pokeApiAtom);
    _$pokeApiAtom.reportObserved();
    return super.pokeApi;
  }

  @override
  set pokeApi(PokeAPI value) {
    _$pokeApiAtom.context.conditionallyRunInAction(() {
      super.pokeApi = value;
      _$pokeApiAtom.reportChanged();
    }, _$pokeApiAtom, name: '${_$pokeApiAtom.name}_set');
  }

  final _$loadingListAtom = Atom(name: 'PokemonStoreBase.loadingList');

  @override
  bool get loadingList {
    _$loadingListAtom.context.enforceReadPolicy(_$loadingListAtom);
    _$loadingListAtom.reportObserved();
    return super.loadingList;
  }

  @override
  set loadingList(bool value) {
    _$loadingListAtom.context.conditionallyRunInAction(() {
      super.loadingList = value;
      _$loadingListAtom.reportChanged();
    }, _$loadingListAtom, name: '${_$loadingListAtom.name}_set');
  }

  final _$lengthAtom = Atom(name: 'PokemonStoreBase.length');

  @override
  int get length {
    _$lengthAtom.context.enforceReadPolicy(_$lengthAtom);
    _$lengthAtom.reportObserved();
    return super.length;
  }

  @override
  set length(int value) {
    _$lengthAtom.context.conditionallyRunInAction(() {
      super.length = value;
      _$lengthAtom.reportChanged();
    }, _$lengthAtom, name: '${_$lengthAtom.name}_set');
  }

  final _$PokemonStoreBaseActionController =
      ActionController(name: 'PokemonStoreBase');

  @override
  dynamic fetchList() {
    final _$actionInfo = _$PokemonStoreBaseActionController.startAction();
    try {
      return super.fetchList();
    } finally {
      _$PokemonStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic refreshList({String newURL}) {
    final _$actionInfo = _$PokemonStoreBaseActionController.startAction();
    try {
      return super.refreshList(newURL: newURL);
    } finally {
      _$PokemonStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
