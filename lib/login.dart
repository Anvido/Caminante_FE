import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesion'),
      ),
      body: FormLogin(),
    );
  }
}

class FormLogin extends StatefulWidget {
  @override
  State<FormLogin> createState() => FormLoginState();
}

class FormLoginState extends State<FormLogin> {

  final _formLoginKey = GlobalKey<FormState>();

  Widget _textField() {
    
  }

  @override
  Widget build(BuildContext context) {

    return Center(
        //mainAxisSize: MainAxisSize.min,
        Form(
          key: _formLoginKey,
          child: Column(
            children: <Widget>[
              
            ],
          ),
        )
      ),
    );
  }
}