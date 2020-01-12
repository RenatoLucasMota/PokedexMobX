import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:pokedex_mobx/models/poke_api.dart';
import 'package:pokedex_mobx/store/pokemon_store.dart';
import 'package:pokedex_mobx/store/pokemonv2_store.dart';
import 'package:pokedex_mobx/widgets/about_pokemon.dart';
import 'package:pokedex_mobx/widgets/evolucoes_pokemon.dart';
import 'package:pokedex_mobx/widgets/status_pokemon.dart';
import 'package:provider/provider.dart';

class PokeDetail extends StatefulWidget {
  final Pokemon pokemon;
  final Color cor;
  bool mudouPokemon;

  PokeDetail({Key key, this.pokemon, this.cor, this.mudouPokemon = false})
      : super(key: key);

  @override
  _PokeDetailState createState() => _PokeDetailState();
}

class _PokeDetailState extends State<PokeDetail>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int pageIndex;
  CircularProgressIndicator _circularProgressIndicator;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  Widget progressloading() {
    return Container(
      margin: EdgeInsets.all(8),
      child: Center(child: _circularProgressIndicator),
      height: 15,
      width: 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokemonStore>(context);
    final _pokemonStoreV2 = Provider.of<PokemonV2Store>(context);
    if ((widget.pokemon.name != _pokemonStore.pokemonAnterior.name) ||
        (_pokemonStoreV2.species == null)) {
      _pokemonStoreV2.loadPokemon(nome: _pokemonStore.pokemonAtual.name);
      _pokemonStoreV2.loadSpecie(numero: _pokemonStore.posicaoLista);
      //_tabController.index = 0;
    }
    _circularProgressIndicator = CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(widget.cor),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Center(
          child: TabBar(
            controller: _tabController,
            labelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Google'),
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.black,
            unselectedLabelColor: Color(0xff5f6368),
            isScrollable: true,
            indicator: MD2Indicator(
                //it begins here
                indicatorHeight: 3,
                indicatorColor: widget.cor,
                indicatorSize: MD2IndicatorSize.normal),
            tabs: <Widget>[
              Tab(
                text: "Sobre",
              ),
              Tab(
                text: "Evolução",
              ),
              Tab(
                text: "Status",
              ),
              /*Tab(
                text: "Habilidades",
              )*/
            ],
          ),
        ),
      ),
      body: Observer(
        builder: (BuildContext context) {
          return TabBarView(
            children: [
              AboutPokemon(
                nome: _pokemonStore.pokemonAtual.name,
                numero: _pokemonStore.posicaoLista,
                loading: progressloading(),
              ),
              EvolucoesPokemon(
                loading: progressloading(),
              ),
              StatusPokemon(loading: progressloading(), cor: widget.cor,),
              //new Text("This is notification Tab View 4"),
            ],
            controller: _tabController,
          );
        },
      ),
    );
  }
}
