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
//chama o banco
    handler.initializeDB().whenComplete(() {
      setState(() {});
    });
  }
//excluir do crud
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

            TextButton(

              onPressed: () {
                Navigator.pop(context, false);
              },

              child: const Text(
                "Cancelar",
              ),
            ),

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

    // se confirmou a exclusão
    if (confirmar == true) {
    //deleta a serie
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.categoria),
      ),
  //busca a série no banco
      body: FutureBuilder<List<Serie>>(

        future: handler.retrieveSerie(),

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
                "Erro ao carregar as séries.",
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {

            return const Center(
              child: Text(
                "Nenhuma série cadastrada.",
              ),
            );
          }

          List<Serie> series = snapshot.data!;
//lista das séries
          return ListView.builder(

            itemCount: series.length,

            itemBuilder: (context, index) {

              Serie serie = series[index];

              return Card(

                margin:
                    const EdgeInsets.all(10),

                child: ListTile(

                  title: Text(
                    serie.titulo,
                  ),

                  subtitle: Text(
                    serie.descricao,
                  ),

                  trailing: Row(

                    mainAxisSize:
                        MainAxisSize.min,

                    children: [
        //update do crud
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
//delet do crud
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