import 'package:flutter/material.dart';
import 'request.dart';
import 'register.dart';
import 'storage.dart';

final double auxPadding = 32;

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormLogin(),
    );
  }
}

class FormLogin extends StatefulWidget {
  @override
  State<FormLogin> createState() => FormLoginState();
}

class FormLoginState extends State<FormLogin> {

  //final _formLoginKey = GlobalKey<FormState>();
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController()
  ];
    
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
              child: Text('Inciar Sesión',
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
                width: 200,
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: auxPadding,
              ),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: controllers[0],
                validator: (value) {
                  if (value.isEmpty) {
                    return 'El usuario o email no puede estar vacio';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Usuario o email'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: auxPadding
              ),
              child: TextFormField(
                controller: controllers[1],
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
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: auxPadding
              ),
              child: FlatButton(
                child: Text('Ingresar'),
                color: Colors.teal,
                onPressed: () {
                  var data = {
                    'email': controllers[0].text,
                    'password': controllers[1].text
                  };
                  // Scaffold.of(context).showSnackBar(
                  //   SnackBar(

                  //     content: Text('Autenticando')
                  //   )
                  // );
                  postHttp('/login', data).then(
                    (res) {
                      if (res['token'] != null) {
                        setToken(res['token']);
                        Navigator.of(context).pushReplacementNamed('home');
                      } else {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('El email o la contraseña no son validos')
                          )
                        );
                      }  
                    }
                  );
                },
              ), 
            ),
            Padding(
              padding: EdgeInsets.only(
                top: auxPadding
              ),
              child: InkWell(
                child: Text('Crear una cuenta',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register()
                    ),
                  );
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