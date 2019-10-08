import 'package:flutter/material.dart';
import 'storage.dart';
import 'login.dart';
import 'home.dart';
import 'request.dart';


void main() => runApp(MainApp());

class MainApp extends StatelessWidget {

  final navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) { 

    return MaterialApp(
      navigatorKey: navKey,
      initialRoute: 'verify',
      routes: {
        'verify': (context) => Verify(),
        'login': (context) => Login(),
        'home': (context) => Home()
      },
    );
  }
}

class Verify extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    verifyToken().then(
      (token) {
        if (token == null) {
          Navigator.of(context).pushReplacementNamed('login');
        } else {
          postHttp('/verify', { 'token': token }).then(
            (res) {
              if (res['token'] != null) {
                Navigator.of(context).pushReplacementNamed('home');
              } else {
                Navigator.of(context).pushReplacementNamed('login');
              }
            }
          );
        }
      }
    );

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator()
      )
    );
  }
}