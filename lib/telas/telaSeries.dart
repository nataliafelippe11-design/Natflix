import 'package:flutter/material.dart';
import '../bancosDados/bancoSerie.dart';
import '../models/series.dart';
import 'telaDetalhes.dart';

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

  late DatabaseSeriesHandler handler;

  @override
  void initState() {
    super.initState();

    handler = DatabaseSeriesHandler();

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

      body: FutureBuilder<List<Serie>>(

        future: handler.retrieveSeries(),

        builder: (context, snapshot) {

          // =========================
          // CARREGANDO
          // =========================

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // =========================
          // ERRO
          // =========================

          if (snapshot.hasError) {

            return const Center(
              child: Text(
                "Erro ao carregar as séries.",
              ),
            );
          }

          // =========================
          // NENHUMA SÉRIE
          // =========================

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {

            return const Center(
              child: Text(
                "Nenhuma série cadastrada.",
              ),
            );
          }

          // =========================
          // FILTRA A CATEGORIA
          // =========================

          List<Serie> series = snapshot.data!
              .where(
                (serie) =>
                    serie.categoria ==
                    widget.categoria,
              )
              .toList();

          // =========================
          // CATEGORIA SEM SÉRIES
          // =========================

          if (series.isEmpty) {

            return Center(
              child: Text(
                "Nenhuma série da categoria "
                "${widget.categoria}.",
              ),
            );
          }

          // =========================
          // LISTA DE SÉRIES
          // =========================

          return ListView.builder(

            itemCount: series.length,

            itemBuilder: (context, index) {

              final Serie serie =
                  series[index];

              return Card(

                margin:
                    const EdgeInsets.all(10),

                child: ListTile(

                  // IMAGEM
                  leading: serie.imagem != null &&
                          serie.imagem!.isNotEmpty
                      ? Image.asset(
                          serie.imagem!,
                          width: 50,
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          Icons.tv,
                          size: 40,
                        ),

                  // TÍTULO
                  title: Text(
                    serie.titulo,
                  ),

                  // DESCRIÇÃO
                  subtitle: Text(
                    serie.descricao,
                  ),

                  // DETALHES
                  onTap: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (context) =>
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
