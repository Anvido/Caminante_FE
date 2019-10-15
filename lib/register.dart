import 'package:caminantapp/request.dart';
import 'package:flutter/material.dart';
import 'storage.dart';

const double auxPadding = 32;

class Register extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormRegister(),
    );
  }
}

class FormRegister extends StatefulWidget {
  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {

  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _emailController = TextEditingController();

  _onPressed() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Processing Data')
      )
    );

    Map<String, dynamic> data = {
      "username": _usernameController.text,
      "email": _emailController.text,
      "password": _passwordController.text
    };
    postHttp('/register', data).then(
      (res) {
        print(res);
        setToken(res['token']).then(
          (val) {
            Navigator.of(context).pushReplacementNamed('home');
          }
        );
      }
    ).catchError(
      (err) {
        removeIp();
        Navigator.of(context).pushReplacementNamed('ipget');
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: auxPadding
              ),
              child: Text('Registrarse',
                style: TextStyle(
                  fontSize: 30
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: auxPadding,
              ),
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                width: 150,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: auxPadding,
              ),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'El usuario no puede estar vacio';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Usuario'
                ),
                controller: _usernameController,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: auxPadding,
              ),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'El email no puede estar vacio';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email'
                ),
                controller: _emailController,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: auxPadding
              ),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'La contraseña no puede estar vacia';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Contraseña'
                ),
                obscureText: true,
                controller: _passwordController,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: auxPadding
              ),
              child: FlatButton(
                color: Theme.of(context).primaryColor,
                child: Text('Crear cuenta'),
                onPressed: () {
                  _onPressed();
                },
              ), 
            ),
            Padding(
              padding: EdgeInsets.only(
                top: auxPadding
              ),
              child: InkWell(
                child: Text('Regresar',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).accentColor
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                splashColor: Colors.transparent,
              )
            )
          ],
        ),
      )
    );
  }
}