import 'dart:convert';
import 'package:http/http.dart' as http;

class FraseApi {
  static const String url =
      'https://movie-quotes-api.vercel.app/api/v1/quotes';

  static Future<Map<String, dynamic>> buscarFrase() async {
    final resposta = await http
        .get(Uri.parse(url))
        .timeout(const Duration(seconds: 15));

    print('STATUS HTTP: ${resposta.statusCode}');

    if (resposta.statusCode != 200) {
      throw Exception(
        'Servidor retornou status ${resposta.statusCode}',
      );
    }

    final dados = jsonDecode(resposta.body);

    print('JSON RECEBIDO DA API: $dados');

    if (dados is! Map<String, dynamic>) {
      throw Exception('Formato de resposta inesperado.');
    }

    final filmes = dados['data'];

    if (filmes is! List || filmes.isEmpty) {
      throw Exception('Nenhum filme encontrado na API.');
    }

    final List<Map<String, dynamic>> todasFrases = [];

    for (final filme in filmes) {
      if (filme is! Map<String, dynamic>) {
        continue;
      }

      final quotes = filme['quotes'];

      if (quotes is! List) {
        continue;
      }

      for (final quote in quotes) {
        if (quote is String && quote.trim().isNotEmpty) {
          todasFrases.add({
            'quote': quote,
            'title': filme['title'] ?? 'Filme desconhecido',
            'year': filme['year'],
          });
        }
      }
    }

    if (todasFrases.isEmpty) {
      throw Exception('Nenhuma frase válida encontrada.');
    }

    // Seleciona uma frase com base no dia do mês.
    final dia = DateTime.now().day;
    final indice = (dia - 1) % todasFrases.length;

    final fraseSelecionada = todasFrases[indice];

    return fraseSelecionada;
  }
}
