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

    //abre a tela splash e verifica o usuário salvo
    verificarSessao();
  }

  //inicia uma função que pode terminar no futuro

  Future<void> verificarSessao() async {

  //demora 2 s para abrir o login, pois espera a ação do futuro terminar
    await Future.delayed(const Duration(seconds: 2));

    // busca o usuário salvo
    String? usuarioSalvo = await PreferenciasUsuario.obterUsuario();

    if (!mounted) return;

    // se encontrou o usuário, vai para a Tela Inicial; caso contrário, vai para o Login
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
  //mostra a imagem
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