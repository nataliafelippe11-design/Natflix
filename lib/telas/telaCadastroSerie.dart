import 'package:flutter/material.dart';
import '../bancosDados/bancoSerie.dart';
import '../models/series.dart';
import 'telaInicial.dart';
import 'telaFilmes.dart';
import 'telaSeries.dart';
import 'telaPerfil.dart';
import 'telaFavoritos.dart';

class TelaCadastroSerie extends StatefulWidget {
  // Série opcional:
  // null = cadastrar
  // preenchida = editar
  final Serie? serie;

  const TelaCadastroSerie({
    super.key,
    this.serie,
  });

  @override
  State<TelaCadastroSerie> createState() => _TelaCadastroSerieState();
}

class _TelaCadastroSerieState extends State<TelaCadastroSerie> {
  // CONTROLLERS
  final tituloController = TextEditingController();
  final categoriaController = TextEditingController();
  final descricaoController = TextEditingController();
  final imagemController = TextEditingController();

  // BANCO DE DADOS
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();

    handler = DatabaseHandler();

    // Se estiver editando uma série,
    // preenche os campos automaticamente.
    if (widget.serie != null) {
      tituloController.text = widget.serie!.titulo;
      categoriaController.text = widget.serie!.categoria;
      descricaoController.text = widget.serie!.descricao;
      imagemController.text = widget.serie!.imagem ?? "";
    }
  }

  // ==========================================
  // CREATE / UPDATE
  // ==========================================

  Future<void> salvarSerie() async {
    // Verifica se é edição
    if (widget.serie == null) {
      // ==========================
      // CREATE
      // ==========================

      Serie serie = Serie(
        titulo: tituloController.text,
        categoria: categoriaController.text,
        descricao: descricaoController.text,
        imagem: imagemController.text,
      );

      await handler.insertSerie([serie]);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Série cadastrada com sucesso!"),
        ),
      );
    } else {
      // ==========================
      // UPDATE
      // ==========================

      Serie serieAtualizada = Serie(
        id: widget.serie!.id,
        titulo: tituloController.text,
        categoria: categoriaController.text,
        descricao: descricaoController.text,
        imagem: imagemController.text,
      );

      await handler.updateSerie(serieAtualizada);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Série atualizada com sucesso!"),
        ),
      );
    }

    // Volta para a tela anterior
    Navigator.pop(context);
  }

  @override
  void dispose() {
    tituloController.dispose();
    categoriaController.dispose();
    descricaoController.dispose();
    imagemController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool editando = widget.serie != null;

    return Scaffold(
      // ==========================================
      // DRAWER
      // ==========================================

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

            // INÍCIO
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

            // FILMES
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

            // SÉRIES
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

            // CADASTRAR SÉRIE
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

      // ==========================================
      // APP BAR
      // ==========================================

      appBar: AppBar(
        title: Text(
          editando ? "Editar Série" : "Cadastrar Série",
        ),
      ),

      // ==========================================
      // FORMULÁRIO
      // ==========================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // TÍTULO
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                labelText: "Título",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // CATEGORIA
            TextField(
              controller: categoriaController,
              decoration: const InputDecoration(
                labelText: "Categoria",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // DESCRIÇÃO
            TextField(
              controller: descricaoController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Descrição",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // IMAGEM
            TextField(
              controller: imagemController,
              decoration: const InputDecoration(
                labelText: "Imagem (assets/arquivo.jpg)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            // BOTÃO
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
