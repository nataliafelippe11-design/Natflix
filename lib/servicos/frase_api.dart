import 'dart:convert';
import 'package:http/http.dart' as http;

class FraseApi {
  static const String url =
      'https://movie-quotes-api.vercel.app/api/v1/quotes';

  static Future<Map<String, dynamic>> buscarFrase() async {
    try {
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
          if (quote is String &&
              quote.trim().isNotEmpty &&
              quote.trim().length <= 300) {
            todasFrases.add({
              'quote': quote.trim(),
              'title': filme['title'] ?? 'Filme desconhecido',
              'year': filme['year'],
            });
          }
        }
      }

      if (todasFrases.isEmpty) {
        throw Exception('Nenhuma frase válida encontrada.');
      }

      // escolher uma frase com base no dia do mês.
      final dia = DateTime.now().day;
      final indice = (dia - 1) % todasFrases.length;

      print('TOTAL DE FRASES: ${todasFrases.length}');
      print('FRASE SELECIONADA: ${todasFrases[indice]['quote']}');

      return todasFrases[indice];
    } catch (e) {
      print('ERRO REAL DA FRASE: $e');
      rethrow;
    }
  }
}