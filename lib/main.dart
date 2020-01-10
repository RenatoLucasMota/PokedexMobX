import 'package:flutter/material.dart';
import 'package:news_mobx/pages/pokedex_page.dart';
import 'package:news_mobx/store/pokemon_store.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.white,
            accentColor: Colors.grey,
            brightness: Brightness.light),
        home: PokeDexPage(),
      ),
      providers: [
        Provider<PokemonStore>(
          create: (_) => PokemonStore(),
        )
      ],
    );
  }
}
