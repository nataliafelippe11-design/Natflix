import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {

  final String username;

  TelaInicial({required this.username});

  @override
  Widget build(BuildContext context) {

    // DIALOG FILMES
    Future mostrarFilmes() async {

      final selected = await showDialog<String>(

        context: context,

        builder: (BuildContext context) {

          return SimpleDialog(

            title: Text("Filmes"),

            children: [

              SimpleDialogOption(

                onPressed: () {

                  Navigator.pop(context, "Ação");
                },

                child: Text("Ação"),
              ),

              SimpleDialogOption(

                onPressed: () {

                  Navigator.pop(context, "Comédia");
                },

                child: Text("Comédia"),
              ),
            ],
          );
        },
      );

      if (selected != null) {

        print("Filme escolhido: $selected");
      }
    }

    // DIALOG SÉRIES
    Future mostrarSeries() async {

      final selected = await showDialog<String>(

        context: context,

        builder: (BuildContext context) {

          return SimpleDialog(

            title: Text("Séries"),

            children: [

              SimpleDialogOption(

                onPressed: () {

                  Navigator.pop(context, "Drama");
                },

                child: Text("Drama"),
              ),

              SimpleDialogOption(

                onPressed: () {

                  Navigator.pop(context, "Suspense");
                },

                child: Text("Suspense"),
              ),
            ],
          );
        },
      );

      if (selected != null) {

        print("Série escolhida: $selected");
      }
    }

    return Scaffold(

      appBar: AppBar(
        title: Text("Natflix"),
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