import 'package:flutter/material.dart';
import '../models/filmes.dart';
import 'telaDetalhes.dart';

class TelaFilmes extends StatelessWidget {

  final String categoria;

  TelaFilmes({required this.categoria});

  // FILMES DE AÇÃO
  final List<Filme> filmesAcao = [

    Filme(
      titulo: "Batman",
      descricao: "O cavaleiro das trevas protege Gotham.",
      imagem: "assets/batman.jpg",
    ),

    Filme(
      titulo: "Vingadores",
      descricao: "Heróis salvando o mundo.",
      imagem: "assets/vingadores.jpg",
    ),
  ];

  // FILMES DE COMÉDIA
  final List<Filme> filmesComedia = [

    Filme(
      titulo: "As Branquelas",
      descricao: "Dois agentes disfarçados em uma missão.",
      imagem: "assets/asbranquelas.web",
    ),

    Filme(
      titulo: "Gente Grande",
      descricao: "Amigos revivendo momentos da infância.",
      imagem: "assets/gentegrande.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {

    // ESCOLHE A LISTA CONFORME A CATEGORIA
    final List<Filme> filmes = categoria == "Ação"
        ? filmesAcao
        : filmesComedia;

    return Scaffold(

      appBar: AppBar(
        title: Text(categoria),
      ),

      body: ListView.builder(

        itemCount: filmes.length,

        itemBuilder: (context, index) {

          final filme = filmes[index];

          return Card(

            margin: EdgeInsets.all(10),

            child: ListTile(

              leading: Image.asset(
                filme.imagem,
                width: 50,
                fit: BoxFit.cover,
              ),

              title: Text(filme.titulo),

              subtitle: Text(filme.descricao),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (context) => TelaDetalhes(
                      filme: filme,
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