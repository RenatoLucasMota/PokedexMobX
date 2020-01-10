import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_mobx/models/poke_api.dart';
import 'package:news_mobx/store/pokemon_store.dart';
import 'package:news_mobx/utils/consts.dart';
import 'package:provider/provider.dart';

class PokeDetailPage extends StatefulWidget {
  final int index;

  const PokeDetailPage({Key key, this.index}) : super(key: key);

  @override
  _PokeDetailPageState createState() => _PokeDetailPageState();
}

class _PokeDetailPageState extends State<PokeDetailPage>
    with TickerProviderStateMixin {
  Pokemon pokemon = Pokemon();

  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    animationController.forward();
    animationController.addStatusListener(verificaAnimacao);
  }

  verificaAnimacao(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.repeat();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokemonStore>(context);
    int indexAtual = widget.index;
    Pokemon pokemon = _pokemonStore.pokeApi.pokemon[indexAtual];
    Color corPokemon = Consts.getColorType(type: pokemon.type[0]);

    double viewHeigth = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: corPokemon,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            PreferredSize(
              preferredSize: Size.fromHeight(200),
              child: Column(
                children: <Widget>[
                  AppBar(
                    brightness: Brightness.dark,
                    title: Text(
                      pokemon.name,
                      style: TextStyle(
                          fontFamily: 'Google',
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        OverflowBox(
                          maxWidth: double.infinity,
                          maxHeight: double.infinity,
                          child: Opacity(
                            child: Image.asset(
                              'assets/images/pokeball.png',
                              alignment: Alignment.center,
                              height: 200,
                            ),
                            opacity: 0.2,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop(null);
                          },
                        ),
                      ],
                    ),
                    backgroundColor: corPokemon,
                    elevation: 0,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 0, left: 20, right: 20, bottom: 10),
                    color: corPokemon,
                    height: 200,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            setTipos(index: indexAtual),
                            Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Hero(
                                  tag: 'pokeball' + pokemon.name,
                                  child: FittedBox(
                                    alignment: Alignment.center,
                                    child: Opacity(
                                      child: RotationTransition(
                                        child: Image.asset(
                                          'assets/images/pokeball.png',
                                          height: 80,
                                        ),
                                        turns: Tween(begin: 0.0, end: 1.0)
                                            .animate(animationController),
                                      ),
                                      opacity: 0.5,
                                    ),
                                  ),
                                ),
                                Text(
                                  '#' + pokemon.numero,
                                  style: TextStyle(
                                      fontFamily: 'Google',
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: viewHeigth,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 140),
              child: Align(
                alignment: Alignment.center,
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: pokemon.numero,
                  child: Container(
                    height: 180,
                    width: 180,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (context, url) => new Container(
                        color: Colors.transparent,
                      ),
                      imageUrl:
                          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${pokemon.numero}.png',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setTipos({int index}) {
    final _pokemonStore = Provider.of<PokemonStore>(context);
    List<Widget> lista = [];
    _pokemonStore.pokeApi.pokemon[index].type.forEach((nome) {
      lista.add(
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  nome.trim(),
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            )
          ],
        ),
      );
    });
    return Row(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
