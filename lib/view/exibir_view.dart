import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/projeto_controller.dart';

class ExibirView extends StatefulWidget {
  const ExibirView({super.key});

  @override
  State<ExibirView> createState() => _ExibirViewState();
}

class _ExibirViewState extends State<ExibirView> {
  final ctrl = GetIt.I.get<ProjetoController>();

  late VoidCallback listener;

  @override
  void initState() {
    super.initState();
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
      backgroundColor: const Color(0xFFE8F5E9),

      appBar: AppBar(
        title: const Text('Dados do Usuário'),
        backgroundColor: Colors.green[700],
        actions: [
          
        ],
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informações',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),

                const SizedBox(height: 20),

                // NOME
                Text('Nome', style: TextStyle(color: Colors.grey[700])),
                Text(ctrl.txtNome.text, style: const TextStyle(fontSize: 22)),

                const SizedBox(height: 15),

                // EMAIL
                Text('Email', style: TextStyle(color: Colors.grey[700])),
                Text(ctrl.txtEmail.text, style: const TextStyle(fontSize: 22)),

                const SizedBox(height: 15),

                // TELEFONE
                Text('Telefone', style: TextStyle(color: Colors.grey[700])),
                Text(
                  ctrl.txtTelefone.text,
                  style: const TextStyle(fontSize: 22),
                ),

                const SizedBox(height: 15),

                // NOTIFICAÇÕES
                Text(
                  'Receber notificações',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Text(
                  ctrl.notificar ? 'Sim' : 'Não',
                  style: const TextStyle(fontSize: 22),
                ),

                const SizedBox(height: 30),

                // BOTÕES
                Row(
                  children: [
                    // ENTRAR 
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login'); 
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Confirmar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    // VOLTAR 
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
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
