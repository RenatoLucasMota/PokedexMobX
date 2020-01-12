import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pokedex_mobx/pages/pokedetail_page.dart';
import 'package:pokedex_mobx/store/pokemon_store.dart';
import 'package:pokedex_mobx/widgets/poke_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final _pokemonStore = Provider.of<PokemonStore>(context);
    _pokemonStore.fetchList();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Entypo.sound_mix),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            right: -90,
            top: -40,
            child: Opacity(
              child: Image.asset(
                'assets/images/pokeball_dark.png',
                height: 250,
              ),
              opacity: 0.1,
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: statusBarHeight,
                ),
                Container(
                  height: 108,
                  width: widthScreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Pokedex',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Google',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Tooltip(
                          child: IconButton(
                            icon: Icon(
                              Entypo.cross,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              exit(0);
                            },
                          ),
                          message: 'Close app',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: heightScreen - 108 - statusBarHeight,
                  child: Observer(
                    name: 'pagehome',
                    builder: (_) => (_pokemonStore.pokeApi != null)
                        ? AnimationLimiter(
                            child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.all(12),
                              addAutomaticKeepAlives: false,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount: _pokemonStore.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  columnCount: 2,
                                  child: ScaleAnimation(
                                    child: ScaleAnimation(
                                      child: GestureDetector(
                                        child: PokeItem(
                                          cor: _pokemonStore.getColorPokemon(
                                              type: _pokemonStore.pokeApi
                                                  .pokemon[index].type[0]),
                                          tipos: _pokemonStore
                                              .pokeApi.pokemon[index].type,
                                          nome: _pokemonStore
                                              .pokeApi.pokemon[index].name,
                                          image: Hero(
                                            tag: _pokemonStore
                                                .pokeApi.pokemon[index].numero,
                                            child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 40, top: 40),
                                                child: _pokemonStore.getImage(
                                                    numero: _pokemonStore
                                                        .pokeApi
                                                        .pokemon[index]
                                                        .numero)),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  PokeDetailPage(index: index),
                                              fullscreenDialog: true,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
