import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:news_mobx/store/pokemon_store.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pokemonStore = PokemonStore();
  ScrollController _controller;

  _scrollListener() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if ((_pokemonStore.pokeApi != null) &&
          (_pokemonStore.loadingList == false)) {
        await _pokemonStore.refreshList(newURL: _pokemonStore.pokeApi.next);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _pokemonStore.fetchList();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pokedex-MobX'),
        ),
        body: Observer(
          builder: (_) => ((_pokemonStore.pokeApi != null))
              ? ListView.builder(
                  controller: _controller,
                  itemCount: _pokemonStore.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(_pokemonStore.pokeApi.results[index].name),
                        leading: Image.network(
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index+1}.png',
                        ),
                      ),
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
