import 'package:flutter/material.dart';
import '../bancosDados/bancoFilme.dart';
import '../models/filmes.dart';
import 'telaInicial.dart';
import 'telaFilmes.dart';
import 'telaSeries.dart';
import 'telaPerfil.dart';
import 'telaFavoritos.dart';

class TelaCadastroFilme extends StatefulWidget {

  // Filme que será editado.
  // Se for null, significa que estamos cadastrando.
  final Filme? filme;

  const TelaCadastroFilme({
    super.key,
    this.filme,
  });

  @override
  State<TelaCadastroFilme> createState() =>
      _TelaCadastroFilmeState();
}

class _TelaCadastroFilmeState
    extends State<TelaCadastroFilme> {

  final tituloController = TextEditingController();
  final categoriaController = TextEditingController();
  final descricaoController = TextEditingController();
  final imagemController = TextEditingController();

  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();

    handler = DatabaseHandler();

    // Se existe um filme, estamos editando.
    if (widget.filme != null) {

      tituloController.text =
          widget.filme!.titulo;

      categoriaController.text =
          widget.filme!.categoria;

      descricaoController.text =
          widget.filme!.descricao;

      imagemController.text =
          widget.filme!.imagem ?? "";
    }
  }

  // =========================
  // SALVAR
  // =========================

  Future<void> salvarFilme() async {

    // =========================
    // UPDATE
    // =========================

    if (widget.filme != null) {

      Filme filmeAtualizado = Filme(

        id: widget.filme!.id,

        titulo: tituloController.text,

        categoria: categoriaController.text,

        descricao: descricaoController.text,

        imagem: imagemController.text,
      );

      await handler.updateFilme(
        filmeAtualizado,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Filme atualizado com sucesso!",
          ),
        ),
      );

    }

    // =========================
    // CREATE
    // =========================

    else {

      Filme filme = Filme(

        titulo: tituloController.text,

        categoria: categoriaController.text,

        descricao: descricaoController.text,

        imagem: imagemController.text,
      );

      await handler.insertFilme([filme]);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Filme cadastrado com sucesso!",
          ),
        ),
      );
    }

    // Limpa os campos

    tituloController.clear();
    categoriaController.clear();
    descricaoController.clear();
    imagemController.clear();

    // Volta para a tela anterior

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    // Define o título conforme a operação

    final bool editando =
        widget.filme != null;

    return Scaffold(

      // =========================
      // DRAWER
      // =========================

      drawer: Drawer(
        child: ListView(
          children: [

            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),

              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

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

            // INÍCIO

            ListTile(
              leading: const Icon(Icons.home),

              title: const Text("Início"),

              onTap: () {

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                        const TelaInicial(
                      username: "Natália",
                    ),
                  ),
                );
              },
            ),

            // FILMES

            ListTile(
              leading: const Icon(Icons.movie),

              title: const Text("Filmes"),

              onTap: () {

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                        TelaFilmes(
                      categoria: "Ação",
                    ),
                  ),
                );
              },
            ),

            // SÉRIES

            ListTile(
              leading: const Icon(Icons.tv),

              title: const Text("Séries"),

              onTap: () {

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                        TelaSeries(
                      categoria: "Drama",
                    ),
                  ),
                );
              },
            ),

            const Divider(),

            // PERFIL

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

            // FAVORITOS

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

            // CADASTRAR FILME

            ListTile(
              leading:
                  const Icon(Icons.library_add),

              title:
                  const Text("Cadastrar Filme"),

              onTap: () {

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                        const TelaCadastroFilme(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // =========================
      // APP BAR
      // =========================

      appBar: AppBar(
        title: Text(
          editando
              ? "Editar Filme"
              : "Cadastrar Filme",
        ),
      ),

      // =========================
      // FORMULÁRIO
      // =========================

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: tituloController,

              decoration:
                  const InputDecoration(
                labelText: "Título",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
                  categoriaController,

              decoration:
                  const InputDecoration(
                labelText: "Categoria",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
                  descricaoController,

              decoration:
                  const InputDecoration(
                labelText: "Descrição",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
                  imagemController,

              decoration:
                  const InputDecoration(
                labelText:
                    "Imagem (assets/arquivo.jpg)",

                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(

              onPressed:
                  salvarFilme,

              child: Text(
                editando
                    ? "Atualizar Filme"
                    : "Salvar Filme",
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
    imagemController.dispose();

    super.dispose();
  }
}