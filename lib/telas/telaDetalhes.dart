import 'package:flutter/material.dart';
import '../models/filmes.dart';
import '../models/series.dart';

class TelaDetalhes extends StatelessWidget {

  // FILME OU SÉRIE
  final Filme? filme;
  final Series? serie;

  TelaDetalhes({
    this.filme,
    this.serie,
  });

  @override
  Widget build(BuildContext context) {

    // ESCOLHE QUAL OBJETO ESTÁ SENDO USADO
    final titulo = filme?.titulo ?? serie!.titulo;

    final descricao = filme?.descricao ?? serie!.descricao;

    final imagem = filme?.imagem ?? serie!.imagem;

    return Scaffold(

      appBar: AppBar(
        title: Text(titulo),
      ),

      body: Padding(

        padding: EdgeInsets.all(20),

        child: Column(

          children: [

            Image.asset(
              imagem,
              height: 250,
            ),

            SizedBox(height: 20),

            Text(
              titulo,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Text(
              descricao,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}