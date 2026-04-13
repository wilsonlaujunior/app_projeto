import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/projeto_controller.dart';

final g = GetIt.instance;

class ResultadoView extends StatefulWidget {
  const ResultadoView({super.key});

  @override
  State<ResultadoView> createState() => _ResultadoViewState();
}

class _ResultadoViewState extends State<ResultadoView> {

  final TextEditingController concController = TextEditingController();
  final TextEditingController volController = TextEditingController();
  final TextEditingController cartController = TextEditingController();

  double totalCelulas = 0;
  double totalCart = 0;

  late Paciente paciente;
  late String dia;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)!.settings.arguments as Map;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // DIA SELECIONADO
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
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
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Concentração celular (cel/mL)',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              // VOLUME
              TextField(
                controller: volController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Volume (mL)',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              // EXPRESSÃO CAR-T+
              TextField(
                controller: cartController,
                keyboardType: TextInputType.number,
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Calcular',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // TOTAL DE CÉLULAS
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Número de Células Totais: ${totalCelulas.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // TOTAL CÉLULAS CAR-T+
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Número de Células CAR-T+: ${totalCart.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // BOTÃO SALVAR
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: salvar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
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
        double.tryParse(concController.text) ?? 0;

    final double vol =
        double.tryParse(volController.text) ?? 0;

    final double cart =
        double.tryParse(cartController.text) ?? 0;

    setState(() {
      totalCelulas = conc * vol;
      totalCart = (cart / 100) * totalCelulas;
    });
  }

  // SALVAR NO CONTROLLER
  void salvar() {

    final controller = g<ProjetoController>();

    final double conc =
        double.tryParse(concController.text) ?? 0;

    final double vol =
        double.tryParse(volController.text) ?? 0;

    final double cart =
        double.tryParse(cartController.text) ?? 0;

    controller.salvarResultado(
      paciente: paciente,
      dia: dia,
      concentracao: conc,
      volume: vol,
      cart: cart,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dados salvos com sucesso!'),
      ),
    );
  }

  // CARREGAR DADOS SALVOS
  void carregarDados() {

    final controller = g<ProjetoController>();

    final resultado =
        controller.getResultado(paciente, dia);

    if (resultado != null) {
      concController.text = resultado.concentracao.toString();
      volController.text = resultado.volume.toString();
      cartController.text = resultado.cart.toString();

      totalCelulas = resultado.totalCelulas;
      totalCart = resultado.totalCart;
    }
  }
}