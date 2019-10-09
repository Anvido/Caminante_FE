import 'package:caminantapp/ipgetter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        'ipget': (context) => IpGetter(),
        'verify': (context) => Verify(),
        'login': (context) => Login(),
        'home': (context) => Home()
      },
    );
  }
}

class Verify extends StatelessWidget {

  _getIp() async {
    SharedPreferences mem = await SharedPreferences.getInstance();
    if (mem.containsKey('ip')) {
      return mem.getString('ip');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    updateIp().then(
      (val) {
        print("verify: $val");
        if (val == null) {
          Navigator.of(context).pushReplacementNamed('ipget');
        } else {
          verifyToken().then(
            (token) {
              if (token == null) {
                Navigator.of(context).pushReplacementNamed('login');
              } else {
                _getIp().then(
                  (ip) {
                    if (ip == null) {
                      Navigator.of(context).pushReplacementNamed('ipget');
                    } else {
                      postHttp('/verify', { 'token': token }).then(
                        (res) {
                          print(res);
                          if (res['token'] != null) {
                            Navigator.of(context).pushReplacementNamed('home');
                          } else {
                            Navigator.of(context).pushReplacementNamed('login');
                          }
                        }
                      ).catchError((err) {
                        Navigator.of(context).pushReplacementNamed('ipget');
                        updateIp();
                        print("Desde aqui============================================");
                        print(err);
                      });
                    }
                  }
                );
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