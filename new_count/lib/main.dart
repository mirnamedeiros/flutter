import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(title: "Contador de pessoas", home: Home()));
}

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _pessoas = 0;
  String _mensagem = "Pode entrar!";
  void _changePeople(int delta) {
    setState(() {
      _pessoas += delta;
      if (_pessoas >= 20) {
        _mensagem = "Lotado, não pode entrar!";
        _pessoas = 20;
      } else if (_pessoas < 0) {
        _mensagem = "Pode entrar!";
        _pessoas = 0;
      } else {
        _mensagem = "Pode Entrar!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "imagens/restaurant.jpg",
          fit: BoxFit.cover,
          height: 3000.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Pessoas: $_pessoas",
              style: const TextStyle(
                  color: Colors.teal, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    child: const Text(
                      "+1",
                      style: TextStyle(fontSize: 40.0, color: Colors.teal),
                    ),
                    onPressed: () {
                      _changePeople(1);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    child: const Text(
                      "-1",
                      style: TextStyle(fontSize: 40.0, color: Colors.teal),
                    ),
                    onPressed: () {
                      _changePeople(-1);
                    },
                  ),
                ),
              ],
            ),
            Text(
              _mensagem,
              style: const TextStyle(
                  color: Colors.teal,
                  fontStyle: FontStyle.italic,
                  fontSize: 30),
            ) //text
          ],
        )
      ],
    );
  }
}
