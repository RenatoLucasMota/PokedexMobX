import 'package:flutter/material.dart';
import 'package:pokedex_mobx/pages/home_page.dart';
import 'package:pokedex_mobx/store/pokemon_store.dart';
import 'package:pokedex_mobx/store/pokemonv2_store.dart';
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
        title: 'Pokedex',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.white,
            accentColor: Colors.red,
            brightness: Brightness.light,),
        home: HomePage(),/*PokeDexPage()*/
      ),
      providers: [
        Provider<PokemonStore>(
          create: (_) => PokemonStore(),
        ),
        Provider<PokemonV2Store>(
          create: (_) => PokemonV2Store(),
        ) 
      ],
    );
  }
}
