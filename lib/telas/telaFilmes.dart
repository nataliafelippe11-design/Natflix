import 'package:flutter/material.dart';
import '../bancosDados/bancoFilme.dart';
import '../models/filmes.dart';
import 'telaDetalhes.dart';

class TelaFilmes extends StatefulWidget {
  final String categoria;

  const TelaFilmes({
    super.key,
    required this.categoria,
  });

  @override
  State<TelaFilmes> createState() => _TelaFilmesState();
}

class _TelaFilmesState extends State<TelaFilmes> {
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();

    handler = DatabaseHandler();

    handler.initializeDB().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoria),
      ),

      body: FutureBuilder<List<Filme>>(
        future: handler.retrieveFilme(),

        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Erro ao carregar os filmes."),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Nenhum filme cadastrado."),
            );
          }

          List<Filme> filmes = snapshot.data!
              .where((filme) => filme.categoria == widget.categoria)
              .toList();

          if (filmes.isEmpty) {
            return Center(
              child: Text(
                "Nenhum filme da categoria ${widget.categoria}.",
              ),
            );
          }

          return ListView.builder(
            itemCount: filmes.length,

            itemBuilder: (context, index) {

              Filme filme = filmes[index];

              return Card(
                margin: const EdgeInsets.all(10),

                child: ListTile(

                  leading: Image.asset(
                    filme.imagem ?? "",
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

          );

        },

      ),

    );

  }

}