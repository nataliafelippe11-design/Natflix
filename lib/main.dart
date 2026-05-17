import 'package:flutter/material.dart';
import 'telas/telaLogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home: TelaLogin(),
    );
  }
}