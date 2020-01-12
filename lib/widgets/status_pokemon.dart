import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_mobx/models/poke_apiv2.dart';
import 'package:pokedex_mobx/store/pokemonv2_store.dart';
import 'package:pokedex_mobx/widgets/progress_bar.dart';
import 'package:provider/provider.dart';

class StatusPokemon extends StatelessWidget {
  final Widget loading;
  final Color cor;
  int _total = 0;

  StatusPokemon({Key key, this.loading, this.cor}) : super(key: key);
  Widget montaLinha({Stats stats, double widthScreen}) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            corrigiNomeStatus(nome: stats.stat.name),
            style: TextStyle(
                fontFamily: 'Google', fontSize: 16, color: Colors.grey[700]),
          ),
          width: widthScreen / 5.5, //MediaQuery.of(context).size.width / 4,
        ),
        Container(
          child: Text(
            stats.baseStat.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Google',
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          width: 40,
        ),
        Expanded(
            flex: 5,
            child: ProgressBar(
              color: (stats.stat.name != 'Total') ?
               (stats.baseStat.toDouble() / 160 > 0.5 ) ? Colors.teal: Colors.red:
               (stats.baseStat.toDouble() / 680 > 0.5 ) ? Colors.teal: Colors.red,
                progress: stats.stat.name == 'Total'
                    ? stats.baseStat.toDouble() / 680
                    : stats.baseStat.toDouble() / 160))
      ],
    );
  }

  String corrigiNomeStatus({String nome}) {
    switch (nome) {
      case 'speed':
        return 'Speed';
        break;
      case 'special-defense':
        return 'Sp. Def';
        break;
      case 'special-attack':
        return 'Sp. Att';
        break;
      case 'defense':
        return 'Defense';
        break;
      case 'attack':
        return 'Attack';
        break;
      case 'hp':
        return 'HP';
        break;
      default:
        return 'Total';
        break;
    }
  }

  List<Widget> montaListaStatus({PokemonV2 pokemonV2, double widthScreen}) {
    List<Widget> lista = [];
    pokemonV2.stats.forEach((stat) {
      _total = _total + stat.baseStat;
      lista.add(montaLinha(stats: stat, widthScreen: widthScreen));
      lista.add(SizedBox(
        height: 10,
      ));
    });

    lista.add(montaLinha(
        stats: Stats(baseStat: _total, stat: Ability(name: 'Total')),
        widthScreen: widthScreen));
    _total = 0;
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    final _pokemonStoreV2 = Provider.of<PokemonV2Store>(context);
    return Observer(
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(30),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: (_pokemonStoreV2.pokemonV2 == null)
                ? Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Align(
                  child: loading,
                  alignment: Alignment.topCenter,
                ),
              )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: montaListaStatus(
                        pokemonV2: _pokemonStoreV2.pokemonV2,
                        widthScreen: MediaQuery.of(context).size.width)),
          ),
        );
      },
    );
  }
}
