import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static const String _keyUsuario = 'user_email';

  // salva o e-mail no login
  static Future<void> salvarUsuario(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsuario, email);
  }

  // busca o e-mail salvo (não retorna nada se não existir)
  static Future<String?> obterUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsuario);
  }
}
