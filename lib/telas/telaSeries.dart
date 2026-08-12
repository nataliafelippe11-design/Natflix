import 'package:flutter/material.dart';
import '../bancosDados/bancoSerie.dart';
import '../models/series.dart';
import 'telaDetalhes.dart';
import 'telaCadastroSerie.dart';

class TelaSeries extends StatefulWidget {

  final String categoria;

  const TelaSeries({
    super.key,
    required this.categoria,
  });

  @override
  State<TelaSeries> createState() => _TelaSeriesState();
}

class _TelaSeriesState extends State<TelaSeries> {

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
  // DELETE - EXCLUIR SÉRIE
  // ==========================================

  Future<void> excluirSerie(Serie serie) async {

    final confirmar = await showDialog<bool>(
      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text(
            "Excluir Série?",
          ),

          content: Text(
            'Deseja realmente excluir "${serie.titulo}"?',
          ),

          actions: [

            // CANCELAR
            TextButton(

              onPressed: () {
                Navigator.pop(context, false);
              },

              child: const Text(
                "Cancelar",
              ),
            ),

            // EXCLUIR
            TextButton(

              onPressed: () {
                Navigator.pop(context, true);
              },

              child: const Text(
                "Excluir",
              ),
            ),
          ],
        );
      },
    );

    // Se confirmou a exclusão
    if (confirmar == true) {

      await handler.deleteSerie(
        serie.id!,
      );

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          content: Text(
            "${serie.titulo} foi excluído.",
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

      body: FutureBuilder<List<Serie>>(

        future: handler.retrieveSerie(),

        builder: (context, snapshot) {

          // ==================================
          // CARREGANDO
          // ==================================

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ==================================
          // ERRO
          // ==================================

          if (snapshot.hasError) {

            return const Center(
              child: Text(
                "Erro ao carregar as séries.",
              ),
            );
          }

          // ==================================
          // NENHUMA SÉRIE
          // ==================================

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {

            return const Center(
              child: Text(
                "Nenhuma série cadastrada.",
              ),
            );
          }

          List<Serie> series = snapshot.data!;

          // ==================================
          // LISTA DE SÉRIES
          // ==================================

          return ListView.builder(

            itemCount: series.length,

            itemBuilder: (context, index) {

              Serie serie = series[index];

              return Card(

                margin:
                    const EdgeInsets.all(10),

                child: ListTile(

                  // ==================================
                  // IMAGEM
                  // ==================================

                  

                leading: serie.imagem != null && serie.imagem!.isNotEmpty
                    ? Image.asset(
                        serie.imagem!,
                        width: 50,
                        height: 70,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.tv,
                        size: 40,
                      ),



                  // ==================================
                  // TÍTULO
                  // ==================================

                  title: Text(
                    serie.titulo,
                  ),

                  // ==================================
                  // DESCRIÇÃO
                  // ==================================

                  subtitle: Text(
                    serie.descricao,
                  ),

                  // ==================================
                  // BOTÕES
                  // ==================================

                  trailing: Row(

                    mainAxisSize:
                        MainAxisSize.min,

                    children: [

                      // ==============================
                      // EDITAR
                      // ==============================

                      IconButton(

                        icon: const Icon(
                          Icons.edit,
                        ),

                        tooltip:
                            "Editar série",

                        onPressed: () async {

                          await Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder:
                                  (context) =>
                                      TelaCadastroSerie(
                                serie: serie,
                              ),

                            ),

                          );

                          setState(() {});
                        },
                      ),

                      // ==============================
                      // EXCLUIR
                      // ==============================

                      IconButton(

                        icon: const Icon(
                          Icons.delete,
                        ),

                        tooltip:
                            "Excluir série",

                        onPressed: () {

                          excluirSerie(
                            serie,
                          );

                        },
                      ),
                    ],
                  ),

                  // ==================================
                  // DETALHES
                  // ==================================

                  onTap: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder:
                            (context) =>
                                TelaDetalhes(
                          serie: serie,
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