import 'package:flutter/material.dart';
import 'telaFilmes.dart';
import 'telaSeries.dart';
import 'telaPerfil.dart';
import 'telaFavoritos.dart';
import 'telaCadastroFilme.dart';
import 'telaCadastroSerie.dart';

class TelaInicial extends StatelessWidget {

  final String username;

  const TelaInicial({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {

    // DIALOG FILMES

    Future<void> mostrarFilmes() async {

      showDialog(
        context: context,

        builder: (BuildContext context) {

          return SimpleDialog(

            title: const Text("Filmes"),

            children: [


              // AÇÃO

              SimpleDialogOption(

                onPressed: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) => TelaFilmes(
                        categoria: "Ação",
                      ),
                    ),
                  );

                },

                child: const Text("Ação"),
              ),

              // COMÉDIA

              SimpleDialogOption(

                onPressed: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) => TelaFilmes(
                        categoria: "Comédia",
                      ),
                    ),
                  );

                },

                child: const Text("Comédia"),
              ),
            ],
          );
        },
      );
    }

    // DIALOG SÉRIES

    Future<void> mostrarSeries() async {

      showDialog(
        context: context,

        builder: (BuildContext context) {

          return SimpleDialog(

            title: const Text("Séries"),

            children: [

              // DRAMA

              SimpleDialogOption(

                onPressed: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) => TelaSeries(
                        categoria: "Drama",
                      ),
                    ),
                  );

                },

                child: const Text("Drama"),
              ),

              // COMÉDIA

              SimpleDialogOption(

                onPressed: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) => TelaSeries(
                        categoria: "Comédia",
                      ),
                    ),
                  );

                },

                child: const Text("Comédia"),
              ),
            ],
          );
        },
      );
    }

    // SCAFFOLD

    return Scaffold(

      // DRAWER

      drawer: Drawer(

        child: ListView(

          children: [

            // CABEÇALHO

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

              leading: const Icon(
                Icons.home,
              ),

              title: const Text(
                "Início",
              ),

              onTap: () {

                Navigator.pop(context);

              },
            ),

            // FILMES

            ListTile(

              leading: const Icon(
                Icons.movie,
              ),

              title: const Text(
                "Filmes",
              ),

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

              leading: const Icon(
                Icons.tv,
              ),

              title: const Text(
                "Séries",
              ),

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

            // CADASTRAR FILME

            ListTile(

              leading: const Icon(
                Icons.add_box,
              ),

              title: const Text(
                "Cadastrar Filme",
              ),

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

            // CADASTRAR SÉRIE

            ListTile(

              leading: const Icon(
                Icons.add_box,
              ),

              title: const Text(
                "Cadastrar Série",
              ),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (context) =>
                        const TelaCadastroSerie(),

                  ),
                );
              },
            ),

            const Divider(),

            // ==================================
            // PERFIL
            // ==================================

            ListTile(

              leading: const Icon(
                Icons.person,
              ),

              title: const Text(
                "Perfil",
              ),

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

            // ==================================
            // FAVORITOS
            // ==================================

            ListTile(

              leading: const Icon(
                Icons.favorite,
              ),

              title: const Text(
                "Favoritos",
              ),

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
          ],
        ),
      ),

      // ==========================================
      // APP BAR
      // ==========================================

      appBar: AppBar(

        title: const Text(
          "Natflix",
        ),
      ),

      // ==========================================
      // CONTEÚDO
      // ==========================================

      body: Center(

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            // ==================================
            // USUÁRIO
            // ==================================

            Text(

              "Bem-vindo, $username",

              style: const TextStyle(

                fontSize: 24,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            // ==================================
            // BOTÃO FILMES
            // ==================================

            ElevatedButton(

              onPressed: mostrarFilmes,

              child: const Text(
                "Filmes",
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // ==================================
            // BOTÃO SÉRIES
            // ==================================

            ElevatedButton(

              onPressed: mostrarSeries,

              child: const Text(
                "Séries",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
