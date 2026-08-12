import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  // SALVAR USUÁRIO
  static Future<void> salvarUsuario(String username) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'username',
      username,
    );
  }

  // BUSCAR USUÁRIO
  static Future<String?> buscarUsuario() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('username');
  }

  // REMOVER USUÁRIO
  static Future<void> removerUsuario() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('username');
  }
}