import 'package:flutter/material.dart';
import '../bancosDados/bancoFilme.dart';
import '../models/filmes.dart';
import 'telaInicial.dart';
import 'telaFilmes.dart';
import 'telaSeries.dart' hide TelaFilmes;
import 'telaPerfil.dart';
import 'telaFavoritos.dart';

class TelaCadastroFilme extends StatefulWidget {
  const TelaCadastroFilme({super.key});

  @override
  State<TelaCadastroFilme> createState() => _TelaCadastroFilmeState();
}

class _TelaCadastroFilmeState extends State<TelaCadastroFilme> {

  final tituloController = TextEditingController();
  final categoriaController = TextEditingController();
  final descricaoController = TextEditingController();
  final imagemController = TextEditingController();

  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
  }

  Future<void> salvarFilme() async {

    Filme filme = Filme(

      titulo: tituloController.text,

      categoria: categoriaController.text,

      descricao: descricaoController.text,

      imagem: imagemController.text,

    );

    await handler.insertFilme([filme]);

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(
        content: Text("Filme cadastrado com sucesso!"),
      ),

    );

    tituloController.clear();
    categoriaController.clear();
    descricaoController.clear();
    imagemController.clear();
  }

  @override
Widget build(BuildContext context) {

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

          // TELA INICIAL
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

          // CADASTRAR FILME
          ListTile(
            leading: const Icon(Icons.library_add),
            title: const Text("Cadastrar Filme"),
            onTap: () {
              Navigator.pop(context);
            },
          ),

        ],
      ),
    ),

    appBar: AppBar(
      title: const Text("Cadastrar Filme"),
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

          TextField(
            controller: imagemController,
            decoration: const InputDecoration(
              labelText: "Imagem (assets/arquivo.jpg)",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: salvarFilme,
            child: const Text("Salvar Filme"),
          ),

        ],
      ),
    ),
  );
}}