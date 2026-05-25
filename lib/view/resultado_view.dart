import 'package:app_projeto/model/paciente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultadoView extends StatefulWidget {
  const ResultadoView({super.key});

  @override
  State<ResultadoView> createState() =>
      _ResultadoViewState();
}

class _ResultadoViewState
    extends State<ResultadoView> {

  final TextEditingController concController =
      TextEditingController();

  final TextEditingController volController =
      TextEditingController();

  final TextEditingController cartController =
      TextEditingController();

  double totalCelulas = 0;
  double totalCart = 0;

  late Paciente paciente;
  late String dia;

  final FirebaseFirestore db =
      FirebaseFirestore.instance;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)!
            .settings
            .arguments as Map;

    paciente = args['paciente'];

    dia = args['dia'];

    carregarDados();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Inserir Resultado'),
        backgroundColor: Colors.green,
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // DIA
              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: Text(

                  'Dia: $dia',

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // CONCENTRAÇÃO
              TextField(

                controller: concController,

                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText:
                      'Concentração celular (cel/mL)',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              // VOLUME
              TextField(

                controller: volController,

                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText: 'Volume (mL)',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              // CAR-T
              TextField(

                controller: cartController,

                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText: 'CAR-T+ (%)',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 25),

              // BOTÃO CALCULAR
              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed: calcular,

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green,
                  ),

                  child: const Text(
                    'Calcular',

                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // TOTAL CÉLULAS
              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: Text(

                  'Número de Células Totais: '
                  '${totalCelulas.toStringAsFixed(2)}',

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // TOTAL CART
              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: Text(

                  'Número de Células CAR-T+: '
                  '${totalCart.toStringAsFixed(2)}',

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // SALVAR
              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed: salvar,

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green,
                  ),

                  child: const Text(
                    'Salvar',

                    style: TextStyle(
                      color: Colors.white,
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

  
  // CALCULAR
  
  void calcular() {

    final double conc =
        double.tryParse(
              concController.text.replaceAll(',', '.'),
            ) ??
            0;

    final double vol =
        double.tryParse(
              volController.text.replaceAll(',', '.'),
            ) ??
            0;

    final double cart =
        double.tryParse(
              cartController.text.replaceAll(',', '.'),
            ) ??
            0;

    setState(() {

      totalCelulas = conc * vol;

      totalCart =
          (cart / 100) * totalCelulas;
    });
  }

  
  // SALVAR FIRESTORE
 

          Future<void> salvar() async {

            final double conc =
                double.tryParse(
                      concController.text.replaceAll(',', '.'),
                    ) ??
                    0;

            final double vol =
                double.tryParse(
                      volController.text.replaceAll(',', '.'),
                    ) ??
                    0;

            final double cart =
                double.tryParse(
                      cartController.text.replaceAll(',', '.'),
                    ) ??
                    0;

            try {

              await db
                  .collection('resultados')

                  // ID FIXO
                  .doc('${paciente.id}_$dia')

                  .set({

                'idPaciente': paciente.id,

                'dia': dia,

                'concentracao': conc,

                'volume': vol,

                'cart': cart,

                'cel_totais': totalCelulas,

                'cel_positivas': totalCart,
              });

              ScaffoldMessenger.of(context)
                  .showSnackBar(

                const SnackBar(
                  content: Text(
                    'Dados salvos com sucesso!',
                  ),
                ),
              );

            } catch (e) {

              ScaffoldMessenger.of(context)
                  .showSnackBar(

                SnackBar(
                  content: Text(
                    'Erro ao salvar: $e',
                  ),
                ),
              );
            }
          }

          
        // CARREGAR DADOS
       

        Future<void> carregarDados() async {

          try {

            final query = await db
                .collection('resultados')
                .where(
                  'idPaciente',
                  isEqualTo: paciente.id,
                )
                .where(
                  'dia',
                  isEqualTo: dia,
                )
                .get();

            if (query.docs.isNotEmpty) {

              final dados =
                  query.docs.first.data();

              concController.text =
                  dados['concentracao']
                      .toString();

              volController.text =
                  dados['volume']
                      .toString();

              cartController.text =
                  dados['cart']
                      .toString();

              setState(() {

                totalCelulas =
                    (dados['cel_totais'] as num)
                        .toDouble();

                totalCart =
                    (dados['cel_positivas'] as num)
                        .toDouble();
              });
            }

          } catch (e) {

            debugPrint(
              'Erro ao carregar resultado: $e',
            );
          }
        }

  @override
  void dispose() {

    concController.dispose();
    volController.dispose();
    cartController.dispose();

    super.dispose();
  }
}