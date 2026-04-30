import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contando livros',
      theme: ThemeData(primarySwatch: const Color.fromARGB(131, 174, 5, 5)),
      home: HomePage(),
    );
  }
}   
 
