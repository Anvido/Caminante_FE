import 'package:caminantapp/ipgetter.dart';
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
      theme: ThemeData(
        //brightness: Brightness.dark,
        backgroundColor: Colors.white,
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      navigatorKey: navKey,
      initialRoute: 'verify',
      routes: {
        'ipget': (context) => IpGetter(),
        'verify': (context) => Verify(),
        'login': (context) => Login(),
        'home': (context) => Home()
      },
    );
  }
}

class Verify extends StatelessWidget {

  _initApp(BuildContext context) {
    updateIp().then(
      (ip) {
        if (ip == null) {
          Navigator.of(context).pushReplacementNamed('ipget');
        } else {
          updateToken().then(
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
                ).catchError(
                  (err) {
                    Navigator.of(context).pushReplacementNamed('ipget');
                    removeIp();
                  }
                );
              }
            }
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    _initApp(context);
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator()
      )
    );
  }
}