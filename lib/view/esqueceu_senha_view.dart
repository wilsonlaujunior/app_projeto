import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controller/login_controller.dart';

class EsqueceuSenhaView extends StatefulWidget {
  const EsqueceuSenhaView({super.key});

  @override
  State<EsqueceuSenhaView> createState() => _EsqueceuSenhaViewState();
}

class _EsqueceuSenhaViewState extends State<EsqueceuSenhaView> {
  final ctrl = GetIt.I.get<LoginController>();

  late VoidCallback listener;

  @override
  void initState() {
    super.initState();

  // LIMPA CAMPO
    ctrl.txtEmailEsqueceuSenha.clear();

    listener = () => setState(() {});
    ctrl.addListener(listener);
  }

  @override
  void dispose() {
    ctrl.removeListener(listener);
    super.dispose();
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

      appBar: AppBar(
        title: const Text('Redefinir senha'),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ÍCONE
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.green[100],
                child: Icon(
                  Icons.lock_reset,
                  size: 40,
                  color: Colors.green[700],
                ),
              ),

              const SizedBox(height: 20),

              // CONTAINER
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    // TEXTO
                    Text(
                      'Informe o e-mail cadastrado para enviarmos o link de recuperação de senha.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // CAMPO EMAIL
                    TextField(
                      controller: ctrl.txtEmailEsqueceuSenha,
                      keyboardType: TextInputType.emailAddress,

                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: const Icon(Icons.email),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // BOTÃO
                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: () {
                          String email =
                              ctrl.txtEmailEsqueceuSenha.text;

                          // VALIDAÇÃO
                          if (email.isEmpty ||
                              !emailValido(email)) {

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Erro: E-mail inválido',
                                ),
                              ),
                            );

                            return;
                          }

                          // FIREBASE
                          ctrl.esqueceuSenha(context);
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),

                        child: const Text(
                          'Recuperar senha',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // VOLTAR
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: Text(
                        'Voltar',
                        style: TextStyle(
                          color: Colors.green[700],
                        ),
                      ),
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