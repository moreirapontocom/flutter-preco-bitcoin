import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _preco = "";

  _atualizar() async {

    String url = "https://blockchain.info/ticker";

    http.Response response = await http.get(url);
    Map<String, dynamic> moedas = json.decode( response.body );

    String lastBRLQuotation = moedas["BRL"]["last"].toString();

    setState(() {
      _preco = "R\$ " + lastBRLQuotation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("images/bitcoin.png"),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
            child: Text(
              _preco,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: TextDecoration.none
              ),
            ),
          ),
          RaisedButton(
            child: Text("Atualizar", style: TextStyle(color: Colors.white),),
            color: Colors.orange,
            onPressed: _atualizar,
          )

        ],
      ),
    );
  }
}