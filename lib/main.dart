import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'CaminanteApp',
    initialRoute: '/login',
    routes: {
      '/login': (context) => Login()
    },
  ));
}