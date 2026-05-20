import 'package:flutter/material.dart';
import '../models/series.dart';
import 'telaDetalhes.dart';

class TelaSeries extends StatelessWidget {

  final String categoria;

  TelaSeries({required this.categoria});

  // SÉRIES DE AÇÃO
  final List<Series> seriesAcao = [

    Series(
      titulo: "Grey's Anatomy",
      descricao: "Médicos salvando vidas.",
      imagem: "assets/grys.jpg",
    ),

    Series(
      titulo: "Gilmore Girls",
      descricao: "Vida de mãe e filha.",
      imagem: "assets/ggirls.jpg",
    ),
  ];

  // SÉRIES DE COMÉDIA
  final List<Series> seriesComedia = [

    Series(
      titulo: "Brooklyn 99",
      descricao: "Polícias resolvendo crimes.",
      imagem: "assets/b99.jpg",
    ),

    Series(
      titulo: "The Office",
      descricao: "Vida de escritório.",
      imagem: "assets/theoffice.webp",
    ),
  ];

  @override
  Widget build(BuildContext context) {

    // ESCOLHE A LISTA CONFORME A CATEGORIA
    final List<Series> series = categoria == "Ação"
        ? seriesAcao
        : seriesComedia;

    return Scaffold(

      appBar: AppBar(
        title: Text(categoria),
      ),

      body: ListView.builder(

        itemCount: series.length,

        itemBuilder: (context, index) {

          final serie = series[index];

          return Card(

            margin: EdgeInsets.all(10),

            child: ListTile(

              leading: Image.asset(
                serie.imagem,
                width: 50,
                fit: BoxFit.cover,
              ),

              title: Text(serie.titulo),

              subtitle: Text(serie.descricao),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (context) => TelaDetalhes(
                      serie: serie,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}