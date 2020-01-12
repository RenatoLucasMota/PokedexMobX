import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_mobx/models/poke_api.dart';
import 'package:pokedex_mobx/store/pokemon_store.dart';
import 'package:pokedex_mobx/widgets/animated_fade.dart';
import 'package:pokedex_mobx/widgets/poke_detail.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:transparent_image/transparent_image.dart';

class PokeDetailPage extends StatefulWidget {
  int index;

  PokeDetailPage({Key key, this.index}) : super(key: key);

  @override
  _PokeDetailPageState createState() => _PokeDetailPageState();
}

class _PokeDetailPageState extends State<PokeDetailPage>
    with TickerProviderStateMixin {
  AnimationController animationController;
  PageController _pageController;
  double _opacity;
  double _opacityTitle;
  double progress = 0;
  double multiple = 1;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _pageController = PageController(initialPage: widget.index);
    _opacity = 1.0;
    _opacityTitle = 0;

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

  double interval(double lower, double upper, double progress) {
    assert(lower < upper);

    if (progress > upper) return 1.0;
    if (progress < lower) return 0.0;

    return ((progress - lower) / (upper - lower)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokemonStore>(context);

    _pokemonStore.setPosicaoLista(index: widget.index);

    double viewWidth = MediaQuery.of(context).size.width;
    double viewHeigth = MediaQuery.of(context).size.height;

    double progress = 0;
    double multiple = 1;
    return Observer(
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: _pokemonStore.corPokemonAtual,
          body: Stack(
            children: <Widget>[
              PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: Column(
                  children: <Widget>[
                    AppBar(
                      actions: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            AnimatedOpacity(
                              child: RotationTransition(
                                child: Image.asset(
                                  'assets/images/pokeball.png',
                                ),
                                turns: Tween(begin: 0.0, end: 1.0)
                                    .animate(animationController),
                              ),
                              opacity: _opacityTitle == 1 ? 0.2 : 0,
                              duration: Duration(milliseconds: 500),
                            ),
                            IconButton(
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {},
                              color: Colors.white,
                            ),
                          ],
                        )
                      ],
                      centerTitle: true,
                      title: Opacity(
                        opacity: _opacityTitle,
                        child: Text(
                          _pokemonStore.pokemonAtual.name,
                          style: TextStyle(
                              fontFamily: 'Google',
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      brightness: Brightness.dark,
                      leading: IconButton(
                        icon: Icon(Entypo.chevron_left),
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
                      height: viewHeigth / 3.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: Opacity(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Observer(
                                      name: 'nome',
                                      builder: (_) {
                                        final Pokemon poke =
                                            _pokemonStore.pokemonAtual;
                                        return Flexible(
                                          child: Text(
                                            poke.name,
                                            style: TextStyle(
                                                fontFamily: 'Google',
                                                color: Colors.white,
                                                fontSize: 36,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                              opacity: _opacity,
                            ),
                          ),
                          Observer(
                            name: 'pokeball',
                            builder: (_) {
                              return Opacity(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      setTipos(
                                          index: _pokemonStore.posicaoLista),
                                    ],
                                  ),
                                ),
                                opacity: _opacity,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SlidingSheet(
                elevation: 0,
                cornerRadius: 16,
                snapSpec: SnapSpec(
                  snap: true,
                  snappings: [0.55, 0.88], // CORRIGIR PARA TELA PAISAGEM
                  positioning: SnapPositioning.relativeToAvailableSpace,
                ),
                listener: (state) {
                  setState(() {
                    progress = state.progress;
                    multiple = 1 - interval(0.0, 0.8, progress);
                    _opacity = multiple;
                    _opacityTitle = multiple = interval(0.55, 1, progress);
                  });
                },
                builder: (context, state) {
                  return Container(
                    height: MediaQuery.of(context).size.height - 60,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: PokeDetail(
                        pokemon: _pokemonStore.pokemonAtual,
                        cor: _pokemonStore.getColorType(
                            type: _pokemonStore.pokemonAtual.type[0]),
                      ),
                    ),
                  );
                },
              ),
              Observer(
                builder: (context) {
                  return Stack(
                    children: <Widget>[
                      Positioned(
                        top: _opacity > 0
                            ? (viewHeigth / 3.2 - 100 / 2) -
                                (_opacity * -80) -
                                80
                            : 4000,
                        child: SizedBox(
                          width: viewWidth,
                          height: viewHeigth * 0.27,
                          child: PageView.builder(
                            pageSnapping: true,
                            controller: _pageController,
                            physics: BouncingScrollPhysics(),
                            onPageChanged: (index) {
                              int novaPosicao = index;
                              _pokemonStore.setPosicaoLista(index: novaPosicao);
                              widget.index = novaPosicao;
                            },
                            itemCount: _pokemonStore.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              final Pokemon poke =
                                  _pokemonStore.pokeApi.pokemon[index];
                              return Opacity(
                                child: AnimatedPadding(
                                  curve: Curves.easeInOutCubic,
                                  padding: EdgeInsets.only(
                                    top: _pokemonStore.posicaoLista == index
                                        ? 0
                                        : viewHeigth * 0.06,
                                    bottom: _pokemonStore.posicaoLista == index
                                        ? 0
                                        : viewHeigth * 0.06,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Hero(
                                        tag: 'pokeball' + poke.name,
                                        child: Opacity(
                                          child: RotationTransition(
                                            child: Image.asset(
                                              'assets/images/pokeball.png',
                                              width: viewHeigth * 0.24,
                                              height: viewHeigth * 0.24,
                                            ),
                                            turns: Tween(begin: 0.0, end: 1.0)
                                                .animate(animationController),
                                          ),
                                          opacity: 0.2,
                                        ),
                                      ),
                                      Hero(
                                        transitionOnUserGestures: true,
                                        tag: poke.numero,
                                        child: CachedNetworkImage(
                                          alignment: Alignment.bottomCenter,
                                          imageBuilder: (context, image) {
                                            return Image(
                                              image: image,
                                              width: viewHeigth * 0.28,
                                              height: viewHeigth * 0.28,
                                              alignment: Alignment.bottomCenter,
                                              color:
                                                  _pokemonStore.posicaoLista ==
                                                          index
                                                      ? null
                                                      : Colors.black26,
                                            );
                                          },
                                          imageUrl:
                                              'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${poke.numero}.png',
                                        ),
                                      ),
                                    ],
                                  ),
                                  duration: Duration(milliseconds: 600),
                                ),
                                opacity: _opacity,
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: _opacity > 0
                            ? (viewHeigth / 3.2) - (_opacity * -80) - 80
                            : 4000,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child: SizedBox(
                            width: viewWidth - 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(50, 255, 255, 255),
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(Entypo.chevron_left,
                                          color: Colors.white),
                                      onPressed: () {
                                        if ((_opacity == 1) &&
                                            (_pokemonStore.posicaoLista != 0)) {
                                          int novaPosicao =
                                              _pokemonStore.posicaoLista - 1;
                                          _pageController
                                              .jumpToPage(novaPosicao);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(50, 255, 255, 255),
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(Entypo.chevron_right,
                                          color: Colors.white),
                                      onPressed: () {
                                        if ((_opacity == 1) &&
                                            (_pokemonStore.posicaoLista !=
                                                _pokemonStore.length - 1)) {
                                          int novaPosicao =
                                              _pokemonStore.posicaoLista + 1;
                                          _pageController
                                              .jumpToPage(novaPosicao);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
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
