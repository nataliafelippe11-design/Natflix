import 'package:flutter/material.dart';
import '../models/filmes.dart';

class TelaDetalhes extends StatelessWidget {

  final Filme filme;

  TelaDetalhes({required this.filme});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(filme.titulo),
      ),

      body: Padding(

        padding: EdgeInsets.all(20),

        child: Column(

          children: [

            Image.asset(
              filme.imagem,
              height: 250,
            ),

            SizedBox(height: 20),

            Text(
              filme.titulo,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Text(
              filme.descricao,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}