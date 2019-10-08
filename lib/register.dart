import 'package:flutter/material.dart';

const double auxPadding = 32;

class Register extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Iniciar Sesion'),
      ),*/
      body: FormRegister(),
    );
  }
}

class FormRegister extends StatefulWidget {
  @override
  State<FormRegister> createState() => FormRegisterState();
}

class FormRegisterState extends State<FormRegister> {

  final _formLoginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formLoginKey,
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
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: auxPadding
                ),
                child: FlatButton(
                  color: Colors.teal,
                  child: Text('Crear cuenta'),
                  onPressed: () {
                    if (_formLoginKey.currentState.validate()) {
                      Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Processing Data')));
                    }
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
                      color: Colors.blueAccent
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
      )
    );
  }
}