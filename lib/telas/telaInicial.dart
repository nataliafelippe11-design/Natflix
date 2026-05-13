import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {

  // variável para receber username
  final String username;

  // construtor
  TelaInicial({required this.username});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Tela Inicial"),
      ),

      body: Center(

        child: Text(

          "Bem-vindo, $username",

          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}