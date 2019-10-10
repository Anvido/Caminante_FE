import 'package:flutter/material.dart';

class Profile extends StatelessWidget {

  final String title = "Perfil";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      body: Center(
        child: Text("Soy el Profile",
          style: TextStyle(
            fontSize: 24
          ),
        )
      )
    );
  }
}