import 'package:flutter/material.dart';

class CreateEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crear evento"),
      ),
      body: Center(
        child: Text("Soy el createEvent",
          style: TextStyle(
            fontSize: 24
          ),
        )
      )
    );
  }
}