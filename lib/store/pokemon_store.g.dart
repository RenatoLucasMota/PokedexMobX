// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokemonStore on PokemonStoreBase, Store {
  final _$posicaoListaAtom = Atom(name: 'PokemonStoreBase.posicaoLista');

  @override
  int get posicaoLista {
    _$posicaoListaAtom.context.enforceReadPolicy(_$posicaoListaAtom);
    _$posicaoListaAtom.reportObserved();
    return super.posicaoLista;
  }

  @override
  set posicaoLista(int value) {
    _$posicaoListaAtom.context.conditionallyRunInAction(() {
      super.posicaoLista = value;
      _$posicaoListaAtom.reportChanged();
    }, _$posicaoListaAtom, name: '${_$posicaoListaAtom.name}_set');
  }

  final _$pokeApiAtom = Atom(name: 'PokemonStoreBase.pokeApi');

  @override
  PokeApi get pokeApi {
    _$pokeApiAtom.context.enforceReadPolicy(_$pokeApiAtom);
    _$pokeApiAtom.reportObserved();
    return super.pokeApi;
  }

  @override
  set pokeApi(PokeApi value) {
    _$pokeApiAtom.context.conditionallyRunInAction(() {
      super.pokeApi = value;
      _$pokeApiAtom.reportChanged();
    }, _$pokeApiAtom, name: '${_$pokeApiAtom.name}_set');
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

  final _$corPokemonAtualAtom = Atom(name: 'PokemonStoreBase.corPokemonAtual');

  @override
  dynamic get corPokemonAtual {
    _$corPokemonAtualAtom.context.enforceReadPolicy(_$corPokemonAtualAtom);
    _$corPokemonAtualAtom.reportObserved();
    return super.corPokemonAtual;
  }

  @override
  set corPokemonAtual(dynamic value) {
    _$corPokemonAtualAtom.context.conditionallyRunInAction(() {
      super.corPokemonAtual = value;
      _$corPokemonAtualAtom.reportChanged();
    }, _$corPokemonAtualAtom, name: '${_$corPokemonAtualAtom.name}_set');
  }

  final _$pokemonAtualAtom = Atom(name: 'PokemonStoreBase.pokemonAtual');

  @override
  Pokemon get pokemonAtual {
    _$pokemonAtualAtom.context.enforceReadPolicy(_$pokemonAtualAtom);
    _$pokemonAtualAtom.reportObserved();
    return super.pokemonAtual;
  }

  @override
  set pokemonAtual(Pokemon value) {
    _$pokemonAtualAtom.context.conditionallyRunInAction(() {
      super.pokemonAtual = value;
      _$pokemonAtualAtom.reportChanged();
    }, _$pokemonAtualAtom, name: '${_$pokemonAtualAtom.name}_set');
  }

  final _$pokemonAnteriorAtom = Atom(name: 'PokemonStoreBase.pokemonAnterior');

  @override
  Pokemon get pokemonAnterior {
    _$pokemonAnteriorAtom.context.enforceReadPolicy(_$pokemonAnteriorAtom);
    _$pokemonAnteriorAtom.reportObserved();
    return super.pokemonAnterior;
  }

  @override
  set pokemonAnterior(Pokemon value) {
    _$pokemonAnteriorAtom.context.conditionallyRunInAction(() {
      super.pokemonAnterior = value;
      _$pokemonAnteriorAtom.reportChanged();
    }, _$pokemonAnteriorAtom, name: '${_$pokemonAnteriorAtom.name}_set');
  }

  final _$PokemonStoreBaseActionController =
      ActionController(name: 'PokemonStoreBase');

  @override
  Widget getThumb({String numero}) {
    final _$actionInfo = _$PokemonStoreBaseActionController.startAction();
    try {
      return super.getThumb(numero: numero);
    } finally {
      _$PokemonStoreBaseActionController.endAction(_$actionInfo);
    }
  }

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
  dynamic getColorPokemon({String type}) {
    final _$actionInfo = _$PokemonStoreBaseActionController.startAction();
    try {
      return super.getColorPokemon(type: type);
    } finally {
      _$PokemonStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPosicaoLista({int index}) {
    final _$actionInfo = _$PokemonStoreBaseActionController.startAction();
    try {
      return super.setPosicaoLista(index: index);
    } finally {
      _$PokemonStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
