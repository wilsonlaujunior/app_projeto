import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/projeto_controller.dart';

class CadastrarView extends StatefulWidget {
  const CadastrarView({super.key});

  @override
  State<CadastrarView> createState() => _CadastrarViewState();
}

class _CadastrarViewState extends State<CadastrarView> {
  final ctrl = GetIt.I.get<ProjetoController>();

  late VoidCallback listener;

  @override
  void initState() {
    super.initState();

    // LIMPAR CAMPOS
    ctrl.txtNome.clear();
    ctrl.txtEmail.clear();
    ctrl.txtTelefone.clear();
    ctrl.txtSenha.clear();
    ctrl.txtConfirmarSenha.clear();

    listener = () => setState(() {});
    ctrl.addListener(listener);
  }

  @override
  void dispose() {
    ctrl.removeListener(listener);
    super.dispose();
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

                // TELEFONE
                TextField(
                  controller: ctrl.txtTelefone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    prefixIcon: const Icon(Icons.phone),
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

                const SizedBox(height: 20),

                // SWITCH
                SwitchListTile(
                  title: const Text('Receber notificações'),
                  value: ctrl.notificar,
                  onChanged: (value) {
                    ctrl.setNotificar(value);
                  },
                ),

                const SizedBox(height: 30),

                // BOTÕES
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () {

                          // VALIDAÇÃO DE EMAIL
                          if (!ctrl.emailValido(ctrl.txtEmail.text)) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Erro: e-mail inválido'),
                                duration: Duration(seconds: 2),
                              ),
                            );

                            return; 
                          }

                          Navigator.pushNamed(context, 'exibir');
                        },
                        child: const Text(
                          'Criar Conta',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

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