import 'package:flutter/material.dart';
import 'telaInicial.dart';

class TelaLogin extends StatefulWidget {

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class LoginData {

  String username = "";
  String password = "";
}

class _TelaLoginState extends State<TelaLogin> {

  LoginData loginData = LoginData();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Login"),
      ),

      body: Container(

        padding: EdgeInsets.all(30),

        child: Form(

          key: formKey,

          child: Column(

            children: [

              // EMAIL
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

              // SENHA
              TextFormField(

                obscureText: true,

                decoration: InputDecoration(
                  labelText: "Senha",
                ),

                validator: (value) {

                  if (value == null || value.length < 8) {
                    return "Senha deve ter 8 caracteres";
                  }

                  return null;
                },

                onSaved: (value) {
                  loginData.password = value!;
                },
              ),

              SizedBox(height: 30),

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
    );
  }
}