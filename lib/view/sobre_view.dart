import 'package:flutter/material.dart';

class SobreView extends StatelessWidget {
  const SobreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),

      appBar: AppBar(
        title: const Text('Sobre'),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ÍCONE DO APP
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.green[100],
                child: Icon(
                  Icons.coronavirus_outlined,
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
                    // NOME DO APP
                    Text(
                      'Chimeric',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),

                    const SizedBox(height: 15),

                    // VERSÃO
                    Text(
                      'Versão 1.0.0',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),

                    const SizedBox(height: 20),

                    // SOBRE
                    Text(
                      'Aplicativo desenvolvido para centralizar o registro de resultados laboratoriais em processos de terapias celulares.\n\n'
                      'Permite o acompanhamento das etapas produtivas, automatiza cálculos críticos e melhora a comunicação entre equipes, reduzindo erros e garantindo maior segurança e rastreabilidade dos dados.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // DESENVOLVEDOR
                    Text(
                      'Desenvolvido por Wilson Lau Júnior',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),

                    const SizedBox(height: 25),

                    // BOTÃO VOLTAR
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Voltar',
                          style: TextStyle(fontSize: 18),
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
