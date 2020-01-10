import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_mobx/models/poke_api.dart';
import 'package:pokedex_mobx/store/pokemon_store.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_mobx/widgets/pokemon_detail_list.dart';

class PokeDetailPage extends StatefulWidget {
  final int index;

  const PokeDetailPage({Key key, this.index}) : super(key: key);

  @override
  _PokeDetailPageState createState() => _PokeDetailPageState();
}

class _PokeDetailPageState extends State<PokeDetailPage>
    with TickerProviderStateMixin {
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

    _pokemonStore.setPosicaoLista(index: widget.index);

    double viewWidth = MediaQuery.of(context).size.width;
    double viewHeigth = MediaQuery.of(context).size.height;

    return Observer(
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: _pokemonStore.corPokemonAtual,
          body: Stack(
            children: <Widget>[
              PreferredSize(
                preferredSize: Size.fromHeight(200),
                child: Column(
                  children: <Widget>[
                    AppBar(
                      brightness: Brightness.dark,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop(null);
                        },
                      ),
                      backgroundColor: _pokemonStore.corPokemonAtual,
                      elevation: 0,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 0, left: 20, right: 20, bottom: 10),
                      color: _pokemonStore.corPokemonAtual,
                      height: 220,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Observer(
                                    name: 'nome',
                                    builder: (_) {
                                      final Pokemon poke =
                                          _pokemonStore.pokemonAtual;
                                      return Text(
                                        poke.name,
                                        style: TextStyle(
                                            fontFamily: 'Google',
                                            color: Colors.white,
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }),
                                Text(
                                  '#' + _pokemonStore.pokemonAtual.numero,
                                  style: TextStyle(
                                      fontFamily: 'Google',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Observer(
                            name: 'pokeball',
                            builder: (_) {
                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    setTipos(index: _pokemonStore.posicaoLista),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: PokemonDetailList(
                          nome: _pokemonStore.pokemonAtual.name,
                          cor: _pokemonStore.corPokemonAtual,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: viewHeigth / 2 - 240,
                left: viewWidth / 2 - 320 / 2,
                child: Container(
                  width: 320,
                  height: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Observer(
                        name: 'botaovoltar',
                        builder: (_) {
                          return CircleAvatar(
                            backgroundColor: Color.fromARGB(50, 255, 255, 255),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios,
                                    color: Colors.white),
                                onPressed: () {
                                  int novaPosicao =
                                      _pokemonStore.posicaoLista - 1;
                                  _pokemonStore.setPosicaoLista(
                                      index: novaPosicao);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      Observer(
                          name: 'imagempokemon',
                          builder: (_) {
                            final Pokemon poke = _pokemonStore.pokemonAtual;
                            return Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Hero(
                                  tag: 'pokeball' + poke.name,
                                  child: FittedBox(
                                    alignment: Alignment.center,
                                    child: Opacity(
                                      child: RotationTransition(
                                        child: Image.asset(
                                          'assets/images/pokeball.png',
                                          height: 175,
                                        ),
                                        turns: Tween(begin: 0.0, end: 1.0)
                                            .animate(animationController),
                                      ),
                                      opacity: 0.2,
                                    ),
                                  ),
                                ),
                                Hero(
                                  transitionOnUserGestures: true,
                                  tag: poke.numero,
                                  child: Container(
                                    height: 180,
                                    width: 180,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return Container(
                                          color: Colors.transparent,
                                        );
                                      },
                                      imageUrl:
                                          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${poke.numero}.png',
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                      Observer(
                        name: 'botaonext',
                        builder: (_) {
                          return CircleAvatar(
                            backgroundColor: Color.fromARGB(50, 255, 255, 255),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.arrow_forward_ios,
                                    color: Colors.white),
                                onPressed: () {
                                  int novaPosicao =
                                      _pokemonStore.posicaoLista + 1;
                                  _pokemonStore.setPosicaoLista(
                                      index: novaPosicao);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
