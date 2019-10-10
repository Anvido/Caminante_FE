import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuración"),
      ),
      body: Center(
        child: Text("Soy el Settings",
          style: TextStyle(
            fontSize: 24
          ),
        )
      )
    );
  }
}