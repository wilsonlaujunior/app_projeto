import 'package:app_projeto/controller/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NovoView extends StatefulWidget {
  const NovoView({super.key});

  @override
  State<NovoView> createState() => _NovoViewState();
}

class _NovoViewState extends State<NovoView> {
  final ctrl = GetIt.I.get<ProjetoController>();

  final txtLote = TextEditingController();
  final txtPeso = TextEditingController();

  String? doencaSelecionada;
  DateTime? dataSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Paciente'),
        backgroundColor: Colors.green[700],
      ),

      backgroundColor: const Color(0xFFE8F5E9),

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
              children: [

                // LOTE
                TextField(
                  controller: txtLote,
                  decoration: InputDecoration(
                    labelText: 'Lote',
                    prefixIcon: const Icon(Icons.add_box),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // PESO
                TextField(
                  controller: txtPeso,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Peso',
                    suffixText: 'Kg',
                    prefixIcon: const Icon(Icons.balance),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // DOENÇA 
                DropdownButtonFormField<String>(
                  // ignore: deprecated_member_use
                  value: doencaSelecionada,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Doença',
                    prefixIcon: const Icon(Icons.medical_services),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'LLA',
                      child: Text('Leucemia Linfoblástica Aguda (LLA)'),
                    ),
                    DropdownMenuItem(
                      value: 'LNH-B',
                      child: Text('Linfoma Não-Hodgkin B (LNH-B)'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      doencaSelecionada = value;
                    });
                  },
                ),

                const SizedBox(height: 15),

                // DATA DE INÍCIO
                TextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: dataSelecionada == null
                        ? ''
                        : '${dataSelecionada!.day.toString().padLeft(2, '0')}/'
                          '${dataSelecionada!.month.toString().padLeft(2, '0')}/'
                          '${dataSelecionada!.year}',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Data de Início',
                    prefixIcon: const Icon(Icons.calendar_month_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onTap: () async {
                    DateTime? data = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (data != null) {
                      setState(() {
                        dataSelecionada = data;
                      });
                    }
                  },
                ),

                const SizedBox(height: 30),

                // BOTÃO INSERIR
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                        if (txtLote.text.isEmpty ||
                            txtPeso.text.isEmpty ||
                            doencaSelecionada == null ||
                            dataSelecionada == null) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Preencha todos os campos'),
                            ),
                          );
                          return;
                        }

                        ctrl.adicionarPaciente(
                          Paciente(
                            lote: txtLote.text,
                            peso: txtPeso.text,
                            doenca: doencaSelecionada!,
                            data:
                                '${dataSelecionada!.day.toString().padLeft(2, '0')}/'
                                '${dataSelecionada!.month.toString().padLeft(2, '0')}/'
                                '${dataSelecionada!.year}',
                          ),
                        );

                        Navigator.pop(context); // volta pra Home
                      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Inserir',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}