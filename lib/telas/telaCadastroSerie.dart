import 'package:flutter/material.dart';
import '../bancosDados/bancoSerie.dart';
import '../models/series.dart';
import 'telaInicial.dart';
import 'telaFilmes.dart';
import 'telaSeries.dart';
import 'telaPerfil.dart';
import 'telaFavoritos.dart';

class TelaCadastroSerie extends StatefulWidget {
  const TelaCadastroSerie({super.key});

  @override
  State<TelaCadastroSerie> createState() => _TelaCadastroSerieState();
}

class _TelaCadastroSerieState extends State<TelaCadastroSerie> {

  final tituloController = TextEditingController();
  final categoriaController = TextEditingController();
  final descricaoController = TextEditingController();
  final imagemController = TextEditingController();

  late DatabaseSeriesHandler handler;

  @override
  void initState() {
    super.initState();

    handler = DatabaseSeriesHandler();
  }

  Future<void> salvarSerie() async {

    Serie serie = Serie(

      titulo: tituloController.text,

      categoria: categoriaController.text,

      descricao: descricaoController.text,

      imagem: imagemController.text,

    );

    await handler.insertSeries([serie]);

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(
        content: Text("Série cadastrada com sucesso!"),
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

            // =========================
            // INÍCIO
            // =========================

            ListTile(

              leading: const Icon(Icons.home),

              title: const Text("Início"),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (context) =>
                        TelaInicial(
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

                    builder: (context) =>
                        TelaFilmes(
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

                    builder: (context) =>
                        TelaSeries(
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

                    builder: (context) =>
                        const TelaPerfil(),

                  ),
                );
              },
            ),

            // =========================
            // FAVORITOS
            // =========================

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

            // =========================
            // CADASTRAR SÉRIE
            // =========================

            ListTile(

              leading:
                  const Icon(Icons.library_add),

              title:
                  const Text("Cadastrar Série"),

              onTap: () {

                Navigator.pop(context);

              },
            ),

          ],
        ),
      ),

      // =========================
      // APP BAR
      // =========================

      appBar: AppBar(

        title:
            const Text("Cadastrar Série"),

      ),

      // =========================
      // FORMULÁRIO
      // =========================

      body: Padding(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            // TÍTULO

            TextField(

              controller:
                  tituloController,

              decoration:
                  const InputDecoration(

                labelText:
                    "Título",

                border:
                    OutlineInputBorder(),

              ),
            ),

            const SizedBox(height: 15),

            // CATEGORIA

            TextField(

              controller:
                  categoriaController,

              decoration:
                  const InputDecoration(

                labelText:
                    "Categoria",

                border:
                    OutlineInputBorder(),

              ),
            ),

            const SizedBox(height: 15),

            // DESCRIÇÃO

            TextField(

              controller:
                  descricaoController,

              decoration:
                  const InputDecoration(

                labelText:
                    "Descrição",

                border:
                    OutlineInputBorder(),

              ),
            ),

            const SizedBox(height: 15),

            // IMAGEM

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

            // BOTÃO SALVAR

            ElevatedButton(

              onPressed:
                  salvarSerie,

              child:
                  const Text("Salvar Série"),

            ),

          ],
        ),
      ),
    );
  }
}

