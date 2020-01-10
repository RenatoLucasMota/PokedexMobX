import 'package:flutter/material.dart';

class PokemonDetailList extends StatelessWidget {
  final String nome;
  final Color cor;

  const PokemonDetailList({Key key, this.nome, this.cor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 45, left: 10, right: 10),
          ),
          CustomTabbAR(
          colorTab: cor,
          itens: ['About', 'Base Sats', 'Evolution', 'Moves'],
          )
        ],
      ),
    );
  }
}

class CustomTabbAR extends StatefulWidget {
  final Color colorTab;
  final List<String> itens;

  const CustomTabbAR({Key key, this.colorTab, this.itens})
      : super(key: key);

  @override
  _CustomTabbARState createState() => _CustomTabbARState();
}

class _CustomTabbARState extends State<CustomTabbAR> {
  List<Widget> _lista = [];

  @override
  void initState() {
    super.initState();
    _lista = getBuildList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _lista,
    );
  }

  List<Widget> get getBuildList {
    List<Widget> lista = [];
    bool active;
    this.widget.itens.forEach(
      (text) {
        active = false;
        if (widget.itens.indexOf(text) == 0) {
          active = true;
        }
        lista.add(
          ItemTab(
            text: text,
            color: widget.colorTab,
            active: active,
          ),
        );
      },
    );
    return lista;
  }
}

class ItemTab extends StatefulWidget {
  final String text;
  final Color color;
  final GestureTapCallback onTap;
  final bool active;

  ItemTab({Key key, this.text, this.color, this.onTap, this.active})
      : super(key: key);

  @override
  _ItemTabState createState() => _ItemTabState();
}

class _ItemTabState extends State<ItemTab> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        width: 80,
        height: 35,
        child: Column(
          children: <Widget>[
            Text(
              this.widget.text,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Google',
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: widget.active ? 4 : 0,
              width: 60,
              decoration: BoxDecoration(
                color: this.widget.color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
