import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _preco;

  Future<Map> _atualizar() async {

    setState(() => {});

    String url = "https://blockchain.info/ticker";

    http.Response response = await http.get(url);
    print( response.body );
    return json.decode( response.body );
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Map>(
      future: _atualizar(),
      builder: (context, snapshot) {

        switch ( snapshot.connectionState ) {
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              _preco = "Erro ao carregar";
            } else {
              print(snapshot.data);
              _preco = "R\$ " + snapshot.data['BRL']['last'].toString();
            }
            break;
          case ConnectionState.none:
          case ConnectionState.waiting:
            _preco = "Atualizando...";
            break;
        }

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
      },
    );

    /*
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
    */
  }
}