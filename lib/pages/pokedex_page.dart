import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_mobx/pages/pokedetail_page.dart';
import 'package:news_mobx/store/pokemon_store.dart';
import 'package:news_mobx/widgets/poke_item.dart';
import 'package:provider/provider.dart';

class PokeDexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        brightness: Brightness.dark,
        leading: OverflowBox(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          alignment: Alignment.center,
          child: Opacity(
            child: Image.asset(
              'assets/images/pokeball_dark.png',
              height: 200,
            ),
            opacity: 0.1,
          ),
        ),
        title: Text(
          'Pokedex',
          style: TextStyle(color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Google',
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokemonStore>(context);
    _pokemonStore.fetchList();
    return Observer(
      builder: (_) => (_pokemonStore.pokeApi != null)
          ? AnimationLimiter(
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(12),
                addAutomaticKeepAlives: false,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
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
                            tipos: _pokemonStore.pokeApi.pokemon[index].type,
                            nome: _pokemonStore.pokeApi.pokemon[index].name,
                            image: Hero(
                              tag: _pokemonStore.pokeApi.pokemon[index].numero,
                              child: Container(
                                  margin: EdgeInsets.only(left: 40, top: 40),
                                  child: _pokemonStore.getImage(
                                      numero: _pokemonStore
                                          .pokeApi.pokemon[index].numero)),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<Null>(
                                builder: (BuildContext context) {
                                  return PokeDetailPage(index: index);
                                },
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
    );
  }
}
