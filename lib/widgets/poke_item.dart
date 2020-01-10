import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_mobx/utils/consts.dart';

class PokeItem extends StatelessWidget {
  final String nome;
  final Widget image;
  final List<String> tipos;

  Widget setTipos() {
    List<Widget> lista = [];
    tipos.forEach((nome) {
      lista.add(
        Column(
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
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      );
    });
    return Column(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  const PokeItem({Key key, this.nome, this.image, this.tipos})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Consts.getColorType(type: tipos[0]),
          borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          child: Stack(
            children: <Widget>[
              Hero(
                child: Container(
                  child: Opacity(
                    child: Image.asset(
                      'assets/images/pokeball.png',
                    ),
                    opacity: 0.1,
                  ),
                ),
                tag: 'pokeball'+this.nome,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      this.nome,
                      style: TextStyle(
                        fontFamily: 'Google',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    setTipos(),
                  ],
                ),
              ),
              Container(child: image)
            ],
          ),
        ),
      ),
    );
  }
}
