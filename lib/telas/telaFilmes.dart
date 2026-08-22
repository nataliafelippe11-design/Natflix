import 'package:flutter/material.dart';
import '../bancosDados/bancoFilme.dart';
import '../models/filmes.dart';
import 'telaDetalhes.dart';
import 'telaCadastroFilme.dart';

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

  Future<void> excluirFilme(Filme filme) async {

    final confirmar = await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(

          title: const Text(
            "Excluir filme?",
          ),

          content: Text(
            "Deseja realmente excluir "
            "\"${filme.titulo}\"?",
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },

              child: const Text(
                "Cancelar",
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },

              child: const Text(
                "Excluir",
              ),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {

      await handler.deleteFilme(
        filme.id!,
      );

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${filme.titulo} foi excluído.",
          ),
        ),
      );
    }
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

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {

            return const Center(
              child: Text(
                "Erro ao carregar os filmes.",
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {

            return const Center(
              child: Text(
                "Nenhum filme cadastrado.",
              ),
            );
          }

          List<Filme> filmes = snapshot.data!;

          return ListView.builder(

            itemCount: filmes.length,

            itemBuilder: (context, index) {

              Filme filme = filmes[index];

              return Card(

                margin:
                    const EdgeInsets.all(10),

                child: ListTile(

                  title: Text(
                    filme.titulo,
                  ),

                  subtitle: Text(
                    filme.descricao,
                  ),

                  trailing: Row(

                    mainAxisSize:
                        MainAxisSize.min,

                    children: [
                      IconButton(

                        icon: const Icon(
                          Icons.edit,
                        ),

                        tooltip:
                            "Editar filme",

                        onPressed: () async {

                          await Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder:
                                  (context) =>
                                      TelaCadastroFilme(
                                filme: filme,
                              ),
                            ),
                          );
                          setState(() {});
                        },
                      ),

                      IconButton(

                        icon: const Icon(
                          Icons.delete,
                        ),

                        tooltip:
                            "Excluir filme",

                        onPressed: () {

                          excluirFilme(
                            filme,
                          );
                        },
                      ),
                    ],
                  ),

                  onTap: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder:
                            (context) =>
                                TelaDetalhes(
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
