import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/projeto_controller.dart';

final g = GetIt.instance;

class EmCursoView extends StatelessWidget {
  const EmCursoView({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = g<ProjetoController>(); // 

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lotes em Curso'),
        backgroundColor: Colors.green,
      ),

      body: controller.pacientes.isEmpty
          ? const Center(
              child: Text(
                'Não há lotes em curso de produção',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )

          : ListView.builder(
              itemCount: controller.pacientes.length,
              itemBuilder: (context, index) {

                final paciente = controller.pacientes[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: ListTile(
                    title: Text(
                      'Lote: ${paciente.lote}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text(
                      'Início: ${paciente.data}',
                    ),

                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          'visualizar',
                          arguments: paciente,
                        );
                      },
                      child: const Text(
                        'Visualizar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        'visualizar',
                        arguments: paciente,
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}