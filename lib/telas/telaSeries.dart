import 'package:flutter/material.dart';
import '../models/series.dart';
import 'telaDetalhes.dart';

class TelaSeries extends StatelessWidget {

  final List<Series> listaSeries = [

    Series(
      titulo: "Gilmore Girls",
      descricao: "A vida de mãe e filha.",
      imagem: "assets/ggirls.jpg",
    ),

    Series(
      titulo: "The Office",
      descricao: "Vida de escritório.",
      imagem: "assets/theoffice.webp",
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Séries"),
      ),

      body: ListView.builder(

        itemCount: listaSeries.length,

        itemBuilder: (context, index) {

          final serie = listaSeries[index];

          return ListTile(

            leading: Image.asset(
              serie.imagem,
              width: 50,
            ),

            title: Text(serie.titulo),

            subtitle: Text(serie.descricao),

            onTap: () {

              showDialog(

                context: context,

                builder: (context) {

                  return AlertDialog(

                    title: Text(serie.titulo),

                    content: Text(serie.descricao),

                    actions: [

                      TextButton(

                        onPressed: () {
                          Navigator.pop(context);
                        },

                        child: Text("Fechar"),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}