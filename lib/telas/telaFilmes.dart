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

  // ==========================================
  // EXCLUIR FILME
  // ==========================================

  Future<void> excluirFilme(Filme filme) async {

    // Confirmação antes de excluir
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

            // CANCELAR
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

            // EXCLUIR
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

    // Se confirmou
    if (confirmar == true) {

      await handler.deleteFilme(
        filme.id!,
      );

      // Atualiza a tela
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

  // ==========================================
  // BUILD
  // ==========================================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.categoria),
      ),

      body: FutureBuilder<List<Filme>>(

        future: handler.retrieveFilme(),

        builder: (context, snapshot) {

          // CARREGANDO
          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ERRO
          if (snapshot.hasError) {

            return const Center(
              child: Text(
                "Erro ao carregar os filmes.",
              ),
            );
          }

          // NENHUM FILME
          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {

            return const Center(
              child: Text(
                "Nenhum filme cadastrado.",
              ),
            );
          }

          List<Filme> filmes = snapshot.data!;

          // LISTA
          return ListView.builder(

            itemCount: filmes.length,

            itemBuilder: (context, index) {

              Filme filme = filmes[index];

              return Card(

                margin:
                    const EdgeInsets.all(10),

                child: ListTile(

                  // =================================
                  // TÍTULO
                  // =================================

                  title: Text(
                    filme.titulo,
                  ),

                  // =================================
                  // DESCRIÇÃO
                  // =================================

                  subtitle: Text(
                    filme.descricao,
                  ),

                  // =================================
                  // BOTÕES
                  // =================================

                  trailing: Row(

                    mainAxisSize:
                        MainAxisSize.min,

                    children: [

                      // =============================
                      // EDITAR
                      // =============================

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

                          // Atualiza a lista
                          setState(() {});
                        },
                      ),

                      // =============================
                      // EXCLUIR
                      // =============================

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

                  // =================================
                  // DETALHES
                  // =================================

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
