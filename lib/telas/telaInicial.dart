import 'package:flutter/material.dart';
import 'telaFilmes.dart';
import 'telaSeries.dart';
import 'telaPerfil.dart';

class TelaInicial extends StatelessWidget {

  final String username;

  TelaInicial({required this.username});

  @override
  Widget build(BuildContext context) {

    // DIALOG FILMES
    Future mostrarFilmes() async {

      showDialog(

        context: context,

        builder: (BuildContext context) {

          return SimpleDialog(

            title: Text("Filmes"),

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

                child: Text("Ação"),
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

                child: Text("Comédia"),
              ),
            ],
          );
        },
      );
    }

    // DIALOG SÉRIES
    Future mostrarSeries() async {

      showDialog(

        context: context,

        builder: (BuildContext context) {

          return SimpleDialog(

            title: Text("Séries"),

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

                child: Text("Drama"),
              ),

              // SUSPENSE
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

                child: Text("Comédia"),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(

      appBar: AppBar(
        title: Text("Natflix"),
      ),

      // MENU LATERAL
      drawer: Drawer(
  child: ListView(
    children: [

      DrawerHeader(
        child: Text(
          "Natflix",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // FILMES
      ListTile(
        leading: Icon(Icons.movie),
        title: Text("Filmes"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaFilmes(
                categoria: "Drama",
              ),
            ),
          );
        },
      ),

      // SÉRIES
      ListTile(
        leading: Icon(Icons.tv),
        title: Text("Séries"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaSeries(
                categoria: "Comédia",
              ),
            ),
          );
        },
      ),

      Divider(),

      // PERFIL
      ListTile(
        leading: Icon(Icons.person),
        title: Text("Perfil"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TelaPerfil(),
            ),
          );
        },
      ),

      // FAVORITOS
      ListTile(
        leading: Icon(Icons.favorite),
        title: Text("Favoritos"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TelaFavoritos(),
            ),
          );
        },
      ),
    ],
  ),
),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Text(

              "Bem-vindo, $username",

              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 40),

            // BOTÃO FILMES
            ElevatedButton(

              onPressed: mostrarFilmes,

              child: Text("Filmes"),
            ),

            SizedBox(height: 20),

            // BOTÃO SÉRIES
            ElevatedButton(

              onPressed: mostrarSeries,

              child: Text("Séries"),
            ),
          ],
        ),
      ),
    );
  }
}