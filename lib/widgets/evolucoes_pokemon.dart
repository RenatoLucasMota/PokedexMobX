import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_mobx/models/evoluton.dart';
import 'package:pokedex_mobx/models/poke_api.dart';
import 'package:pokedex_mobx/models/species.dart';
import 'package:pokedex_mobx/store/pokemon_store.dart';
import 'package:pokedex_mobx/store/pokemonv2_store.dart';
import 'package:provider/provider.dart';

class EvolucoesPokemon extends StatelessWidget {
  final Widget loading;

  Map<String, String> getEvolucoes({EvolvesTo evolvesTo, Chain chain}) {
    Map<String, String> _lista = Map<String, String>();
    if (chain != null) {
      _lista[chain.species.name] = (chain.evolutionDetails.isEmpty)
          ? ' '
          : (chain.evolutionDetails[0].minLevel == null)
              ? (chain.evolutionDetails[0].item == null)
                  ? ' '
                  : chain.evolutionDetails[0].item.name
              : 'Lvl ' + chain.evolutionDetails[0].minLevel.toString();
    }
    if (evolvesTo != null) {
      _lista[evolvesTo.species.name] =
          (evolvesTo.evolutionDetails[0].minLevel == null)
              ? (evolvesTo.evolutionDetails[0].item == null)
                  ? ' '
                  : evolvesTo.evolutionDetails[0].item.name
              : 'Lvl ' + evolvesTo.evolutionDetails[0].minLevel.toString();
    }
    if (chain != null) {
      _lista.addAll(getEvolucoes(evolvesTo: chain.evolvesTo[0]));
    }

    if ((evolvesTo != null) && (evolvesTo.evolvesTo.isNotEmpty)) {
      _lista.addAll(getEvolucoes(evolvesTo: evolvesTo.evolvesTo[0]));
    }

    return _lista;
  }

  String getNumerosPokemon({String nome, PokeApi pokeApi}) {
    for (var f in pokeApi.pokemon) {
      if (f.name == nome) {
        return (f.numero == null ? f.order : f.numero);
      }
    }
    return null;
  }

  bool pokemonExiste({String nome, PokeApi pokeApi}) {
    for (var f in pokeApi.pokemon) {
      if (f.name.toLowerCase() == nome) {
        return true;
      }
    }
  }

  Widget montaLinha(
      {String nomePrimeiro,
      String nomeSegundo,
      String minLevel,
      PokeApi pokeApi}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Center(
                        child: Opacity(
                          child: Image.asset(
                            'assets/images/pokeball_dark.png',
                            height: 50,
                            width: 50,
                          ),
                          opacity: 0.2,
                        ),
                      ),
                      CachedNetworkImage(
                        alignment: Alignment.bottomCenter,
                        placeholder: (context, string) {
                          return Center(child: loading);
                        },
                        imageBuilder: (context, image) {
                          return Image(
                            image: image,
                            width: 60,
                            height: 60,
                            alignment: Alignment.bottomCenter,
                          );
                        },
                        imageUrl:
                            'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${getNumerosPokemon(nome: nomePrimeiro, pokeApi: pokeApi)}.png',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    nomePrimeiro,
                    style: TextStyle(fontFamily: 'Google', fontSize: 16),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        minLevel,
                        style: TextStyle(
                            fontFamily: 'Google',
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(Entypo.chevron_right),
                    ],
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Center(
                        child: Opacity(
                          child: Image.asset(
                            'assets/images/pokeball_dark.png',
                            height: 50,
                            width: 50,
                          ),
                          opacity: 0.1,
                        ),
                      ),
                      CachedNetworkImage(
                        placeholder: (context, string) {
                          return Center(child: loading);
                        },
                        alignment: Alignment.bottomCenter,
                        imageBuilder: (context, image) {
                          return Image(
                            image: image,
                            width: 60,
                            height: 60,
                            alignment: Alignment.bottomCenter,
                          );
                        },
                        imageUrl:
                            'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${getNumerosPokemon(nome: nomeSegundo, pokeApi: pokeApi)}.png',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    nomeSegundo,
                    style: TextStyle(fontFamily: 'Google', fontSize: 16),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget montaEvolucoes({Map<String, String> lista, PokeApi pokeApi}) {
    List<Widget> coluna = [];
    int contador = 0;
    List<ItemEvolucao> listaEvolucao = [];
    String primeiroPokemon = '';
    String segundoPokemon = '';
    String ultimoPokemon = '';
    lista.forEach((nome, level) {
      if (pokemonExiste(nome: nome, pokeApi: pokeApi) != null) {
        contador = contador + 1;
        if (contador == 1) {
          primeiroPokemon = nome;
          if (ultimoPokemon.isNotEmpty) {
            primeiroPokemon = ultimoPokemon;
            segundoPokemon = nome;
            listaEvolucao
                .add(ItemEvolucao(primeiroPokemon, segundoPokemon, level));
          }
        }

        if (contador == 2) {
          segundoPokemon = nome;
          listaEvolucao
              .add(ItemEvolucao(primeiroPokemon, segundoPokemon, level));
          contador = 0;
          ultimoPokemon = segundoPokemon;
        }
      }
    });
    listaEvolucao.forEach((f) {
      coluna.add(montaLinha(
        pokeApi: pokeApi,
        nomePrimeiro:
            f.primeiroPokemon[0].toUpperCase() + f.primeiroPokemon.substring(1),
        nomeSegundo:
            f.segundoPokemon[0].toUpperCase() + f.segundoPokemon.substring(1),
        minLevel: f.minLevel[0].toUpperCase() + f.minLevel.substring(1),
      ));
      coluna.add(SizedBox(height: 20));
    });
    return Column(children: coluna);
  }

  const EvolucoesPokemon({Key key, this.loading}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _pokemonStoreV2 = Provider.of<PokemonV2Store>(context);
    final _pokemonStore = Provider.of<PokemonStore>(context);

    return Observer(
      builder: (BuildContext context) {
        return _pokemonStoreV2.evolucao == null
            ? Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Align(
                  child: loading,
                  alignment: Alignment.topCenter,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    (_pokemonStoreV2.evolucao.chain.evolvesTo.isNotEmpty) ?
                    Text(
                      'Grade de Evoluções',
                      style: TextStyle(
                          fontFamily: 'Google',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ): Container(),
                    (_pokemonStoreV2.evolucao.chain.evolvesTo.isNotEmpty)
                        ? montaEvolucoes(
                            lista: getEvolucoes(
                                chain: _pokemonStoreV2.evolucao.chain),
                            pokeApi: _pokemonStore.pokeApi)
                        : Text('Não há evoluções.', style: TextStyle(
                          fontFamily: 'Google',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),)
                  ],
                ),
              );
      },
    );
  }
}

class ItemEvolucao {
  final String primeiroPokemon;
  final String segundoPokemon;
  final String minLevel;

  ItemEvolucao(this.primeiroPokemon, this.segundoPokemon, this.minLevel);
}
