// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemonv2_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokemonV2Store on PokemonV2StoreBase, Store {
  final _$pokemonV2Atom = Atom(name: 'PokemonV2StoreBase.pokemonV2');

  @override
  PokemonV2 get pokemonV2 {
    _$pokemonV2Atom.context.enforceReadPolicy(_$pokemonV2Atom);
    _$pokemonV2Atom.reportObserved();
    return super.pokemonV2;
  }

  @override
  set pokemonV2(PokemonV2 value) {
    _$pokemonV2Atom.context.conditionallyRunInAction(() {
      super.pokemonV2 = value;
      _$pokemonV2Atom.reportChanged();
    }, _$pokemonV2Atom, name: '${_$pokemonV2Atom.name}_set');
  }

  final _$speciesAtom = Atom(name: 'PokemonV2StoreBase.species');

  @override
  Species get species {
    _$speciesAtom.context.enforceReadPolicy(_$speciesAtom);
    _$speciesAtom.reportObserved();
    return super.species;
  }

  @override
  set species(Species value) {
    _$speciesAtom.context.conditionallyRunInAction(() {
      super.species = value;
      _$speciesAtom.reportChanged();
    }, _$speciesAtom, name: '${_$speciesAtom.name}_set');
  }

  final _$evolucaoAtom = Atom(name: 'PokemonV2StoreBase.evolucao');

  @override
  Evolucao get evolucao {
    _$evolucaoAtom.context.enforceReadPolicy(_$evolucaoAtom);
    _$evolucaoAtom.reportObserved();
    return super.evolucao;
  }

  @override
  set evolucao(Evolucao value) {
    _$evolucaoAtom.context.conditionallyRunInAction(() {
      super.evolucao = value;
      _$evolucaoAtom.reportChanged();
    }, _$evolucaoAtom, name: '${_$evolucaoAtom.name}_set');
  }

  final _$PokemonV2StoreBaseActionController =
      ActionController(name: 'PokemonV2StoreBase');

  @override
  dynamic loadPokemon({String nome}) {
    final _$actionInfo = _$PokemonV2StoreBaseActionController.startAction();
    try {
      return super.loadPokemon(nome: nome);
    } finally {
      _$PokemonV2StoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadSpecie({int numero}) {
    final _$actionInfo = _$PokemonV2StoreBaseActionController.startAction();
    try {
      return super.loadSpecie(numero: numero);
    } finally {
      _$PokemonV2StoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
