import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static const String _keyUsuario = 'user_email';

  // Salva o e-mail no login
  static Future<void> salvarUsuario(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsuario, email);
  }

  // Busca o e-mail salvo (retorna null se não existir)
  static Future<String?> obterUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsuario);
  }
}
