import 'package:app_projeto/controller/paciente_controller.dart';
import 'package:app_projeto/model/paciente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EmCursoView extends StatefulWidget {
  const EmCursoView({super.key});

  @override
  State<EmCursoView> createState() =>
      _EmCursoViewState();
}

class _EmCursoViewState
    extends State<EmCursoView> {

  final ctrl = GetIt.I.get<PacienteController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Lotes em Curso'),
        backgroundColor: Colors.green,
      ),

      body: StreamBuilder<QuerySnapshot>(

        stream: ctrl.listarPacientesEmCurso(),

        builder: (context, snapshot) {

          // ERRO
          if (snapshot.hasError) {

            return const Center(
              child: Text(
                'Erro ao carregar pacientes',
              ),
            );
          }

          // CARREGANDO
          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // SEM DADOS
          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {

            return const Center(
              child: Text(
                'Não há lotes em curso de produção',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          final dados = snapshot.data!.docs;

          return ListView.builder(

            itemCount: dados.length,

            itemBuilder: (context, index) {

              // DOCUMENTO FIRESTORE
              final doc = dados[index];

              // MAP
              final item =
                  doc.data()
                      as Map<String, dynamic>;

              // OBJETO PACIENTE
              final paciente =
                  Paciente.fromJson(
                item,
                doc.id,
              );

              // DATA
              DateTime data =
                  paciente.inicio.toDate();

              return Card(

                margin: const EdgeInsets.all(10),

                elevation: 3,

                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: ListTile(

                  title: Text(
                    'Lote: ${paciente.lote}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    'Início: '
                    '${data.day.toString().padLeft(2, '0')}/'
                    '${data.month.toString().padLeft(2, '0')}/'
                    '${data.year}',
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
                      style: TextStyle(
                        color: Colors.white,
                      ),
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
          );
        },
      ),
    );
  }
}