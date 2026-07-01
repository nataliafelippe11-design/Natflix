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

        theme: ThemeData(

      scaffoldBackgroundColor: const Color.fromARGB(255, 175, 175, 175),

            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 171, 13, 2),
              foregroundColor: Colors.white,
              centerTitle: true,
            ),

            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),

            cardTheme: CardThemeData(
              color: const Color.fromARGB(255, 0, 114, 13),
              elevation: 6,
            ),

            textTheme: const TextTheme(

              titleLarge: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),

              bodyMedium: TextStyle(
                color: Colors.white,
              ),
            ),
          
            fontFamily: "BebasNeue",
  ),

  home: TelaLogin(),
    );
  }
}