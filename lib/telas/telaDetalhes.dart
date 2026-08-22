//toda a tela foi adaptada em razão do banco
import 'package:flutter/material.dart';
import '../models/filmes.dart';
import '../models/series.dart';

class TelaDetalhes extends StatelessWidget {

  // FILME OU SÉRIE
  final Filme? filme;
  final Serie? serie;

  TelaDetalhes({
    this.filme,
    this.serie,
  });

  @override
  Widget build(BuildContext context) {

    // ESCOLHE QUAL OBJETO ESTÁ SENDO USADO
    final titulo = filme?.titulo ?? serie!.titulo;

    final descricao = filme?.descricao ?? serie!.descricao;

    return Scaffold(

      appBar: AppBar(
        title: Text(titulo),
      ),

      body: Padding(

        padding: EdgeInsets.all(20),

        child: Column(

          children: [

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