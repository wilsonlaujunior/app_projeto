import 'package:app_projeto/model/paciente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditarPacienteView extends StatefulWidget {
  const EditarPacienteView({super.key});

  @override
  State<EditarPacienteView> createState() =>
      _EditarPacienteViewState();
}

class _EditarPacienteViewState
    extends State<EditarPacienteView> {

  final txtLote = TextEditingController();

  final txtPeso = TextEditingController();

  final txtDoenca = TextEditingController();

  late Paciente paciente;

  final FirebaseFirestore db =
      FirebaseFirestore.instance;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    paciente =
        ModalRoute.of(context)!
                .settings
                .arguments
            as Paciente;

  // PREENCHER CAMPOS

    txtLote.text = paciente.lote;

    txtPeso.text =
        paciente.peso.toString();

    txtDoenca.text =
        paciente.doenca;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFE8F5E9),

      appBar: AppBar(

        title:
            const Text('Editar Paciente'),

        backgroundColor:
            Colors.green[700],
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Container(

          padding:
              const EdgeInsets.all(20),

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius:
                BorderRadius.circular(20),

            boxShadow: const [

              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
              ),
            ],
          ),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // TÍTULO
              Text(

                'Atualizar Dados',

                style: TextStyle(

                  fontSize: 24,

                  fontWeight:
                      FontWeight.bold,

                  color:
                      Colors.green[800],
                ),
              ),

              const SizedBox(height: 25),

              // LOTE
              TextField(

                controller: txtLote,

                decoration: InputDecoration(

                  labelText: 'Lote',

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(
                            12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // PESO
              TextField(

                controller: txtPeso,

                keyboardType:
                    TextInputType.number,

                decoration: InputDecoration(

                  labelText: 'Peso (Kg)',

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(
                            12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // DOENÇA
              TextField(

                controller: txtDoenca,

                decoration: InputDecoration(

                  labelText: 'Doença',

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(
                            12),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // BOTÃO SALVAR
              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed: atualizarPaciente,

                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        Colors.green[700],

                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 16,
                    ),

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                              12),
                    ),
                  ),

                  child: const Text(

                    'Salvar Alterações',

                    style: TextStyle(

                      color: Colors.white,

                      fontSize: 16,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================
  // ATUALIZAR PACIENTE
  // =====================================

  Future<void>
      atualizarPaciente() async {

    try {

      String lote =
          txtLote.text.trim();

      String doenca =
          txtDoenca.text.trim();

      double peso =
          double.tryParse(

                txtPeso.text.replaceAll(
                    ',', '.'),
              ) ??
              0;

      // =================================
      // VALIDAÇÃO
      // =================================

      if (lote.isEmpty ||
          doenca.isEmpty ||
          peso <= 0) {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          const SnackBar(

            content: Text(
              'Preencha todos os campos corretamente',
            ),
          ),
        );

        return;
      }

      // =================================
      // VALIDAR ID
      // =================================

      if (paciente.id == null ||
          paciente.id!.isEmpty) {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          const SnackBar(

            content: Text(
              'Erro: ID do paciente inválido',
            ),
          ),
        );

        return;
      }

      // =================================
      // VERIFICAR DOCUMENTO
      // =================================

      final doc =
          await db
              .collection('pacientes')
              .doc(paciente.id)
              .get();

      // DOCUMENTO NÃO EXISTE

      if (!doc.exists) {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          const SnackBar(

            content: Text(
              'Paciente não encontrado no banco',
            ),
          ),
        );

        return;
      }

      // =================================
      // UPDATE FIRESTORE
      // =================================

      await db
          .collection('pacientes')
          .doc(paciente.id)
          .update({

        'lote': lote,

        'loteBusca':
            lote.toLowerCase(),

        'peso': peso,

        'doenca': doenca,

        'doencaBusca':
            doenca.toLowerCase(),
      });

      // =================================
      // SUCESSO
      // =================================

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            'Paciente atualizado com sucesso!',
          ),
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content: Text(
            'Erro ao atualizar: $e',
          ),
        ),
      );
    }
  }

  @override
  void dispose() {

    txtLote.dispose();

    txtPeso.dispose();

    txtDoenca.dispose();

    super.dispose();
  }
}