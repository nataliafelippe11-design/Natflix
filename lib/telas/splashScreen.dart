import 'package:flutter/material.dart';
import '../preferences/preferencesUsuario.dart';
import 'telaInicial.dart';
import 'telaLogin.dart';

class TelaSplash extends StatefulWidget {
  const TelaSplash({super.key});

  @override
  State<TelaSplash> createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> {
  @override
  void initState() {
    super.initState();
    verificarSessao();
  }

  Future<void> verificarSessao() async {

    await Future.delayed(const Duration(seconds: 2));

    // Busca o usuário salvo
    String? usuarioSalvo = await PreferenciasUsuario.obterUsuario();

    if (!mounted) return;

    // Se encontrou o usuário, vai para a Tela Inicial; caso contrário, vai para o Login
    if (usuarioSalvo != null && usuarioSalvo.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TelaInicial(username: usuarioSalvo),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TelaLogin(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/natflix_splash.png.png',
          fit: BoxFit.contain,
          width: 250,

        ),
      ),
    );
  }
}