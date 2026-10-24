import 'package:aula13infoa/servicos/frase_api.dart';
import 'package:flutter/material.dart';

class CardFrase extends StatefulWidget {
  const CardFrase({super.key});

  @override
  State<CardFrase> createState() => _CardFraseState();
}

class _CardFraseState extends State<CardFrase> {
  late Future<Map<String, dynamic>> frase;

  @override
  void initState() {
    super.initState();
    frase = FraseApi.buscarFrase();
  }

  void atualizarFrase() {
    setState(() {
      frase = FraseApi.buscarFrase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(
              Icons.format_quote,
              size: 40,
              color: Colors.white,
            ),
            const Text(
              'FRASE DO DIA',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            FutureBuilder<Map<String, dynamic>>(
              future: frase,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Colors.white,
                  );
                }

                if (snapshot.hasError) {
                  return const Text(
                    'Não foi possível carregar a frase. '
                    'Verifique a conexão e tente novamente.',
                    textAlign: TextAlign.center,
                  );
                }

                final dados = snapshot.data!;

                return Text(
                  dados['quote']?.toString() ??
                      dados['quoteText']?.toString() ??
                      dados.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: atualizarFrase,
              icon: const Icon(Icons.refresh),
              label: const Text('Nova frase'),
            ),
          ],
        ),
      ),
    );
  }
}
