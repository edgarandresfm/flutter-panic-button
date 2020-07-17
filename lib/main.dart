import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
//import 'dart:convert';

void main() {
  runApp(new MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.red,
    ),
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  bool _value = false;
  String urlOn1 = 'http://192.168.0.100/cgi-bin/relay.cgi?on';
  String urlOn2 = 'https://dweet.io/dweet/for/ati4664658526?state=on';
  String urlOff1 = 'http://192.168.0.100/cgi-bin/relay.cgi?off';
  String urlOff2 = 'https://dweet.io/dweet/for/ati4664658526?state=off';

  Future makeRequest(bool on) async {
    if (on) {
      try {
        var request1 = await http.get(Uri.encodeFull(urlOn1), headers: {
          'Accept': 'application/json'
        }).timeout(const Duration(seconds: 1));
      } on TimeoutException catch (_) {
        print("Error en conexion local");
        //data1 = json.decode(request1.body);
        var request2 = await http.get(Uri.encodeFull(urlOn2),
            headers: {'Accept': 'application/json'});
        //data2 = json.decode(request2.body);
      }
    } else {
      try {
        var request1 = await http.get(Uri.encodeFull(urlOff1), headers: {
          'Accept': 'application/json'
        }).timeout(const Duration(seconds: 1));
      } on TimeoutException catch (_) {
        print("Error en conexion local");
        //data1 = json.decode(request1.body);
        var request2 = await http.get(Uri.encodeFull(urlOff2),
            headers: {'Accept': 'application/json'});
        //data2 = json.decode(request2.body);
      }
    }
    return;
  }

  void _onChanged(bool value) {
    setState(() {
      _value = value;
      makeRequest(value);
    });
  }

  @override
  Widget build(BuildContext cotext) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Alarma'),
      ),
      body: Center(
        child: Transform.scale(
          scale: 2.5,
          child: new Switch(
              activeColor: Colors.red,
              value: _value,
              onChanged: (bool value) {
                _onChanged(value);
              }),
          //],
        ),
        /*),*/
      ),
    );
  }
}
