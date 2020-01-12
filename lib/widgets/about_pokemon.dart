import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_mobx/models/poke_apiv2.dart';
import 'package:pokedex_mobx/models/species.dart';
import 'package:pokedex_mobx/store/pokemonv2_store.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AboutPokemon extends StatelessWidget {
  final String nome;
  final int numero;
  final Widget loading;

  bool validarListas({var lista1, var lista2}) {
    return (lista1 == null) || (lista2 == null);
  }

  String retornaGeneroIngles({Species especie}) {
    for (var f in especie.genera) {
      if (f.language.name == 'en') {
        return f.genus;
      }
    }
    return null;
  }

  List<Widget> retornaAbilidades({PokemonV2 pokemon}) {
    List<Widget> _lista = [];
    pokemon.abilities.forEach((f) {
      _lista.add(Text(
        f.ability.name,
        textAlign: TextAlign.left,
        style:
            TextStyle(fontFamily: 'Google', fontSize: 16, color: Colors.black),
      ));
    });
    return _lista;
  }

  String retornaDescricaoIngles({Species especie}) {
    for (var f in especie.flavorTextEntries) {
      if (f.language.name == 'en') {
        return f.flavorText;
      }
    }
    return null;
  }

  const AboutPokemon(
      {Key key, this.nome, this.numero, this.loading})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var f = NumberFormat(
      '###,#',
      'pt_BR',
    );
    var x = NumberFormat('###,#', 'pt_BR');
    TextStyle _textStyleTitulo = TextStyle(
        fontFamily: 'Google', fontWeight: FontWeight.bold, fontSize: 16);
    TextStyle _textStyleText = TextStyle(fontFamily: 'Google', fontSize: 16);
    TextStyle _textStyleItem = TextStyle(
      fontFamily: 'Google',
      fontSize: 16,
      color: Colors.grey,
    );
    TextStyle _textStyleDescItem =
        TextStyle(fontFamily: 'Google', fontSize: 16);

    double viewWidth = MediaQuery.of(context).size.width;
    double viewHeigth = MediaQuery.of(context).size.height;
    final _pokemonStoreV2 = Provider.of<PokemonV2Store>(context);
    return Observer(
      builder: (BuildContext context) {
        Species species = _pokemonStoreV2.species;
        PokemonV2 pokemonV2 = _pokemonStoreV2.pokemonV2;
        return ListView(
          physics:
              (viewHeigth > viewWidth) ? NeverScrollableScrollPhysics() : null,
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Descrição',
                      style: _textStyleTitulo,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    validarListas(lista1: species, lista2: pokemonV2)
                        ? loading
                        : Text(
                            retornaDescricaoIngles(especie: species),
                            textAlign: TextAlign.justify,
                            style: _textStyleText,
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Biologia',
                      style: _textStyleTitulo,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    validarListas(lista1: species, lista2: pokemonV2)
                        ? loading
                        : Padding(
                            padding: const EdgeInsets.only(right: 60),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Espécie ',
                                      style: _textStyleItem,
                                    ),
                                    Text(
                                      'Altura ',
                                      style: _textStyleItem,
                                    ),
                                    Text(
                                      'Peso ',
                                      style: _textStyleItem,
                                    ),
                                    Text(
                                      'Anatomia ',
                                      style: _textStyleItem,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      retornaGeneroIngles(especie: species),
                                      style: _textStyleDescItem,
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      x.format(pokemonV2.height),
                                      style: _textStyleDescItem,
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      f.format(pokemonV2.weight) + ' kg',
                                      style: _textStyleDescItem,
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      species.shape.name[0].toUpperCase() +
                                          species.shape.name.substring(1),
                                      style: _textStyleDescItem,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
