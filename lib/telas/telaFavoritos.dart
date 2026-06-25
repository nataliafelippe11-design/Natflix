import 'package:flutter/material.dart';

class TelaFavoritos extends StatelessWidget {
  const TelaFavoritos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Favoritos"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            const Text(

              "Meus Favoritos",

              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(

              child: ListTile(

                leading: const Icon(Icons.movie),

                title: const Text("Vingadores"),

                subtitle: const Text("Filme"),
              ),
            ),

            const SizedBox(height: 10),

            Card(

              child: ListTile(

                leading: const Icon(Icons.movie),

                title: const Text("Batman"),

                subtitle: const Text("Filme"),
              ),
            ),

            const SizedBox(height: 10),

            Card(

              child: ListTile(

                leading: const Icon(Icons.tv),

                title: const Text("The Office"),

                subtitle: const Text("Série"),
              ),
            ),

            const SizedBox(height: 10),

            Card(

              child: ListTile(

                leading: const Icon(Icons.tv),

                title: const Text("Brooklyn 99"),

                subtitle: const Text("Série"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}