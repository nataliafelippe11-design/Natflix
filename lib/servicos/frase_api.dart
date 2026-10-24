import 'dart:convert';
import 'package:http/http.dart' as http;

class FraseApi {
  static const String url =
      'https://movie-quote-api.herokuapp.com/v1/quote/';

  
static Future<Map<String, dynamic>> buscarFrase() async {
  try {
    print('Iniciando consulta à API...');
    print('Endereço: $url');

    final resposta = await http
        .get(Uri.parse(url))
        .timeout(const Duration(seconds: 15));

    print('Status HTTP: ${resposta.statusCode}');
    print('Resposta recebida: ${resposta.body}');

    if (resposta.statusCode != 200) {
      throw Exception(
        'Servidor retornou status ${resposta.statusCode}',
      );
    }

    final dados = jsonDecode(resposta.body);

    if (dados is Map<String, dynamic>) {
      return dados;
    }

    throw Exception('A resposta não é um objeto JSON.');
  } catch (erro, pilha) {
    print('ERRO AO CONSULTAR A API: $erro');
    print(pilha);
    rethrow;
  }
}

}
