import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json-cors&key=2cddc711";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.amber),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
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

  double dolar = 0;
  double euro = 0;

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
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center (
                child: Text(
                  "Caregando dados...",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
            default:
              if(snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Erro ao caregar dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              } else {
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Icon(Icons.monetization_on,
                        size: 150.0, color: Colors.amber),
                      buildTextFormField(
                        "Reais", "R\$", realController, _realChange),
                      const Divider(),
                      buildTextFormField(
                        "Dólar", "R\$", dolarController, _dolarChange),
                      const Divider(),
                      buildTextFormField(
                        "euro", "R\$", eurocontroller, _euroChance),
                    ],
                  ),
                );
              }
          }
        }));
  }
}

Widget buildTextFormField (String label, String prefix, TextEditingController controller, Function f) {
  return TextField(
    onChanged: (value) => f(value),
    controller: controller,
    decoration: InputDecoration(
      labelText:  label, 
      labelStyle:  const TextStyle(color: Colors.amber),
      border:  const OutlineInputBorder(),
      prefixText: "$prefix "),
    style: const TextStyle(color: Colors.amber, fontSize: 25.0),
    keyboardType: const TextInputType.numberWithOptions(decimal:true),
  );
}