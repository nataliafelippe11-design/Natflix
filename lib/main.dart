import 'package:flutter/material.dart';
import 'telas/telaInicial.dart';

void main() {
  runApp(Login());
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class LoginData {
  String username = "";
  String password = "";
}

class _LoginState extends State<Login> {

  LoginData loginData = LoginData();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home: Scaffold(

        appBar: AppBar(
          title: Text("Tela de Login"),
        ),

        body: Container(

          padding: EdgeInsets.all(30),

          child: Form(

            key: formKey,

            child: Column(

              children: [

                // CAMPO EMAIL
                TextFormField(

                  keyboardType: TextInputType.emailAddress,

                  decoration: InputDecoration(
                    labelText: "E-mail",
                    hintText: "nome@email.com",
                  ),

                  validator: (value) {

                    if (value == null || value.isEmpty) {
                      return "Digite o usuário";
                    }

                    return null;
                  },

                  onSaved: (value) {
                    loginData.username = value!;
                  },
                ),

                SizedBox(height: 20),

                // CAMPO SENHA
                TextFormField(

                  obscureText: true,

                  decoration: InputDecoration(
                    labelText: "Senha",
                    hintText: "Digite sua senha",
                  ),

                  validator: (value) {

                    if (value == null || value.length < 8) {
                      return "A senha precisa ter 8 caracteres";
                    }

                    return null;
                  },

                  onSaved: (value) {
                    loginData.password = value!;
                  },
                ),

                SizedBox(height: 30),

                // BOTÃO
                ElevatedButton(

                  child: Text("Login"),

                  onPressed: () {

                    if (formKey.currentState!.validate()) {

                      formKey.currentState!.save();

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (context) => TelaInicial(

                            username: loginData.username,

                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}