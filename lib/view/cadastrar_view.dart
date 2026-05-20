import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controller/login_controller.dart';

class CadastrarView extends StatefulWidget {
  const CadastrarView({super.key});

  @override
  State<CadastrarView> createState() => _CadastrarViewState();
}

class _CadastrarViewState extends State<CadastrarView> {

  final ctrl = GetIt.I.get<LoginController>();

  @override
  void initState() {
    super.initState();

    // LIMPAR CAMPOS
    ctrl.txtNome.clear();
    ctrl.txtEmail.clear();
    ctrl.txtSenha.clear();
    ctrl.txtConfirmarSenha.clear();
  }

  // VALIDAÇÃO EMAIL
  bool emailValido(String email) {
    return RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Cadastrar'),
        backgroundColor: Colors.green[700],
      ),

      backgroundColor: const Color(0xFFE8F5E9),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Container(

            padding: const EdgeInsets.all(20),

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
              children: [

                // NOME
                TextField(
                  controller: ctrl.txtNome,

                  decoration: InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: const Icon(Icons.account_circle),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // EMAIL
                TextField(
                  controller: ctrl.txtEmail,
                  keyboardType: TextInputType.emailAddress,

                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: const Icon(Icons.email),

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
                    prefixIcon: const Icon(Icons.lock),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // CONFIRMAR SENHA
                TextField(
                  controller: ctrl.txtConfirmarSenha,
                  obscureText: true,

                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    prefixIcon: const Icon(Icons.lock),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // BOTÕES
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    // CRIAR CONTA
                    Expanded(
                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),

                        onPressed: () {

                          // CAMPOS VAZIOS
                          if (
                            ctrl.txtNome.text.isEmpty ||
                            ctrl.txtEmail.text.isEmpty ||
                            ctrl.txtSenha.text.isEmpty ||
                            ctrl.txtConfirmarSenha.text.isEmpty
                          ) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Preencha todos os campos',
                                ),
                              ),
                            );

                            return;
                          }

                          // EMAIL
                          if (!emailValido(ctrl.txtEmail.text)) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'E-mail inválido',
                                ),
                              ),
                            );

                            return;
                          }

                          // SENHA
                          if (ctrl.txtSenha.text.length < 6) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'A senha deve ter pelo menos 6 caracteres',
                                ),
                              ),
                            );

                            return;
                          }

                          // CONFIRMAR SENHA
                          if (
                            ctrl.txtSenha.text !=
                            ctrl.txtConfirmarSenha.text
                          ) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'As senhas não coincidem',
                                ),
                              ),
                            );

                            return;
                          }

                          // FIREBASE
                          ctrl.criarConta(context);
                        },

                        child: const Text(
                          'Criar Conta',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    // VOLTAR
                    Expanded(
                      child: OutlinedButton(

                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),

                        onPressed: () {
                          Navigator.pop(context);
                        },

                        child: const Text(
                          'Voltar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}