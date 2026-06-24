import 'package:flutter/material.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  final TextEditingController tempoController = TextEditingController();

  int episodiosPorDia = 0;
  int filmesPorSemana = 0;
  String categoriaUsuario = "";

  bool mostrarResultado = false;

  void calcularEstatisticas() {
    int minutos = int.tryParse(tempoController.text) ?? 0;

    setState(() {
      episodiosPorDia = minutos ~/ 45;
      filmesPorSemana = (minutos * 7) ~/ 120;

      if (minutos < 60) {
        categoriaUsuario = "🍿 Espectadora Casual";
      } else if (minutos <= 180) {
        categoriaUsuario = "🎬 Maratonista";
      } else {
        categoriaUsuario = "🔥 Super Maratonista";
      }

      mostrarResultado = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu Perfil"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Natália Felippe",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Filme favorito: Vingadores: Ultimato",
            ),

            const Text(
              "Série favorita: Stranger Things",
            ),

            const SizedBox(height: 30),

            TextField(
              controller: tempoController,
              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                labelText: "Minutos livres por dia",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: calcularEstatisticas,
              child: const Text("Calcular"),
            ),

            const SizedBox(height: 30),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),

              transitionBuilder:
                  (Widget child,
                      Animation<double> animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },

              child: mostrarResultado
                  ? Card(
                      key: const ValueKey(1),

                      child: Padding(
                        padding: const EdgeInsets.all(16),

                        child: Column(
                          children: [
                            Text(
                              categoriaUsuario,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              "📺 $episodiosPorDia episódios por dia",
                              style:
                                  const TextStyle(fontSize: 18),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              "🎥 $filmesPorSemana filmes por semana",
                              style:
                                  const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}