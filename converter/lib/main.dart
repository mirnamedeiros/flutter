import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json-cors&key=9eed0cc9";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.amber),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dolarController = TextEditingController();
  final eurocontroller = TextEditingController();
  final realController = TextEditingController();

  double dolar;
  double euro;

  void _realChange(String text) {
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    eurocontroller.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChange(String text) {
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (dolar * this.dolar).toStringAsFixed(2);
    eurocontroller.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChance (String text) {
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (euro * this.euro).toStringAsFixed(2);
    eurocontroller.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    eurocontroller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 204, 200, 200),
      appBar: AppBar(
        title: Text("\$ Conversor de Moedas \$"),
        centerTitle:  true,
        backgroundColor: Colors.amber),
      body: FutureBuilder<Map> (
        future: getData(),
        builder: (context, snapshot) {
          
        }),
      ),
    );
  }
}
