import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final ctrl = GetIt.I.get<LoginController>();

  @override
  void initState() {
    super.initState();

    // LIMPAR CAMPOS
    ctrl.txtEmail.clear();
    ctrl.txtSenha.clear();
  }

  // VALIDAÇÃO DE EMAIL
  bool emailValido(String email) {
    return RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // TOPO
              Column(
                children: [

                  Icon(
                    Icons.coronavirus_outlined,
                    color: Colors.green[700],
                    size: 70,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Chimeric',
                    style: TextStyle(
                      color: Colors.green[800],
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // CONTAINER LOGIN
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),

                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    // TÍTULO
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // EMAIL
                    TextField(
                      controller: ctrl.txtEmail,
                      keyboardType: TextInputType.emailAddress,

                      decoration: InputDecoration(
                        labelText: 'Email',

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // SENHA
                    TextField(
                      controller: ctrl.txtSenha,
                      obscureText: true,

                      decoration: InputDecoration(
                        labelText: 'Senha',

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    // ESQUECEU SENHA
                    Align(
                      alignment: Alignment.centerRight,

                      child: TextButton(
                        onPressed: () {

                          if (ctrl.txtEmail.text.isEmpty) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Digite seu email primeiro',
                                ),
                              ),
                            );

                            return;
                          }

                          ctrl.esqueceuSenha(context);
                        },

                        child: Text(
                          'Esqueceu a senha?',
                          style: TextStyle(
                            color: Colors.green[700],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // BOTÃO ENTRAR
                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(

                        onPressed: () {

                          String email = ctrl.txtEmail.text;
                          String senha = ctrl.txtSenha.text;

                          // CAMPOS VAZIOS
                          if (email.isEmpty || senha.isEmpty) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Preencha todos os campos',
                                ),
                              ),
                            );

                            return;
                          }

                          // EMAIL INVÁLIDO
                          if (!emailValido(email)) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'E-mail inválido',
                                ),
                              ),
                            );

                            return;
                          }

                          // LOGIN FIREBASE
                          ctrl.login(context);
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        child: const Text(
                          'Entrar',

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // CADASTRO
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        const Text(
                          'Não tem conta? ',
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              'cadastrar',
                            );
                          },

                          child: Text(
                            'Cadastre-se',

                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}