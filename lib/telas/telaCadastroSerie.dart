import 'package:flutter/material.dart';
import '../bancosDados/bancoSerie.dart';
import '../models/series.dart';
import 'telaInicial.dart';
import 'telaFilmes.dart';
import 'telaSeries.dart';
import 'telaPerfil.dart';
import 'telaFavoritos.dart';

class TelaCadastroSerie extends StatefulWidget {
  final Serie? serie;

  const TelaCadastroSerie({
    super.key,
    this.serie,
  });

  @override
  State<TelaCadastroSerie> createState() => _TelaCadastroSerieState();
}

class _TelaCadastroSerieState extends State<TelaCadastroSerie> {
  final tituloController = TextEditingController();
  final categoriaController = TextEditingController();
  final descricaoController = TextEditingController();

  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();

    handler = DatabaseHandler();

    if (widget.serie != null) {
      tituloController.text = widget.serie!.titulo;
      categoriaController.text = widget.serie!.categoria;
      descricaoController.text = widget.serie!.descricao;
    }
  }

  Future<void> salvarSerie() async {
    // Verifica se é edição
    if (widget.serie == null) {

      Serie serie = Serie(
        titulo: tituloController.text,
        categoria: categoriaController.text,
        descricao: descricaoController.text,
      );

      await handler.insertSerie([serie]);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Série cadastrada com sucesso!"),
        ),
      );
    } else {
      Serie serieAtualizada = Serie(
        id: widget.serie!.id,
        titulo: tituloController.text,
        categoria: categoriaController.text,
        descricao: descricaoController.text,
      );

      await handler.updateSerie(serieAtualizada);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Série atualizada com sucesso!"),
        ),
      );
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    tituloController.dispose();
    categoriaController.dispose();
    descricaoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool editando = widget.serie != null;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.local_movies,
                    color: Colors.white,
                    size: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Natflix",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Início"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TelaInicial(username: "Natália"),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text("Filmes"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TelaFilmes(categoria: "Ação"),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text("Séries"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TelaSeries(categoria: "Drama"),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Perfil"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const TelaPerfil(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text("Favoritos"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const TelaFavoritos(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_add),
              title: const Text("Cadastrar Série"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          editando ? "Editar Série" : "Cadastrar Série",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                labelText: "Título",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: categoriaController,
              decoration: const InputDecoration(
                labelText: "Categoria",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: descricaoController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Descrição",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: salvarSerie,
                icon: Icon(
                  editando ? Icons.edit : Icons.save,
                ),
                label: Text(
                  editando
                      ? "Atualizar Série"
                      : "Salvar Série",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
