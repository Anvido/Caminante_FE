import 'package:flutter/material.dart';
import 'storage.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Cerrar Sesion'),
          onPressed: () {
            removeToken();
            Navigator.of(context).pushReplacementNamed('login');
          },
        ),
      ),
    );
  }
}