import 'package:flutter/material.dart';
import '../bancosDados/bancoFilme.dart';
import '../models/filmes.dart';
import 'telaInicial.dart';
import 'telaFilmes.dart';
import 'telaSeries.dart';
import 'telaPerfil.dart';
import 'telaFavoritos.dart';

class TelaCadastroFilme extends StatefulWidget {
  final Filme? filme;

  const TelaCadastroFilme({
    super.key,
    this.filme,
  });

  @override
  State<TelaCadastroFilme> createState() => _TelaCadastroFilmeState();
}

class _TelaCadastroFilmeState extends State<TelaCadastroFilme> {
  final tituloController = TextEditingController();
  final categoriaController = TextEditingController();
  final descricaoController = TextEditingController();
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();

    handler = DatabaseHandler();

    if (widget.filme != null) {
      tituloController.text = widget.filme!.titulo;
      categoriaController.text = widget.filme!.categoria;
      descricaoController.text = widget.filme!.descricao;
    }
  }

  Future<void> salvarFilme() async {
    if (widget.filme != null) {
      Filme filmeAtualizado = Filme(
        id: widget.filme!.id,
        titulo: tituloController.text,
        categoria: categoriaController.text,
        descricao: descricaoController.text,
      );

      await handler.updateFilme(filmeAtualizado);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Filme atualizado com sucesso!"),
        ),
      );
    } else {
      Filme filme = Filme(
        titulo: tituloController.text,
        categoria: categoriaController.text,
        descricao: descricaoController.text,
      );

      await handler.insertFilme([filme]);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Filme cadastrado com sucesso!"),
        ),
      );
    }

    tituloController.clear();
    categoriaController.clear();
    descricaoController.clear();

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final bool editando = widget.filme != null;

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
                    builder: (context) => const TelaInicial(
                      username: "Natália",
                    ),
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
                    builder: (context) => TelaFilmes(
                      categoria: "Ação",
                    ),
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
                    builder: (context) => TelaSeries(
                      categoria: "Drama",
                    ),
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
                    builder: (context) => const TelaPerfil(),
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
                    builder: (context) => const TelaFavoritos(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_add),
              title: const Text("Cadastrar Filme"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaCadastroFilme(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          editando ? "Editar Filme" : "Cadastrar Filme",
        ),
      ),
      body: Padding(
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
              decoration: const InputDecoration(
                labelText: "Descrição",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: salvarFilme,
              child: Text(
                editando ? "Atualizar Filme" : "Salvar Filme",
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    tituloController.dispose();
    categoriaController.dispose();
    descricaoController.dispose();
    super.dispose();
  }
}