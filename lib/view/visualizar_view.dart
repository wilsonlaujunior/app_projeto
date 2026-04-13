import 'package:flutter/material.dart';
import '../controller/projeto_controller.dart';

class VisualizarView extends StatelessWidget {
  const VisualizarView({super.key});

  @override
  Widget build(BuildContext context) {
    final Paciente p =
        ModalRoute.of(context)!.settings.arguments as Paciente;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),

      appBar: AppBar(
        title: const Text('Detalhes do Lote'),
        backgroundColor: Colors.green[700],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // LOTE
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lote: ${p.lote}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text('Doença: ${p.doenca}'),
                  Text('Peso: ${p.peso} Kg'),
                  Text('Início: ${p.data}'),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Linha do Tempo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // DIAS DE PROCESSO
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 20,
              runSpacing: 25,
              children: [
                timelineItem(context, p, 'D0', 'Enriquecimento\nAtivação'),
                timelineItem(context, p, 'D1', 'Transdução'),
                timelineItem(context, p, 'D4', 'Expansão'),
                timelineItem(context, p, 'D6', 'Debeading'),
                timelineItem(context, p, 'D8', 'Expansão'),
                timelineItem(context, p, 'D10', 'Expansão'),
                timelineItem(context, p, 'D12', 'Produto Final'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  
  Widget timelineItem(
    BuildContext context,
    Paciente p,
    String dia,
    String descricao,
  ) {

    // VERIFICAÇÃO SE TEM RESULTADO
    bool concluido = p.resultados.containsKey(dia);

    return SizedBox(
      width: 95,
      child: Column(
        children: [

         
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                'resultado',
                arguments: {
                  'paciente': p,
                  'dia': dia,
                },
              );
            },
            child: CircleAvatar(
              radius: 26,
              backgroundColor:
                  concluido ? Colors.green[800] : Colors.grey[400],
              child: Text(
                dia,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // DIA
          Text(
            dia,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 5),

          // DESCRIÇÃO
          Text(
            descricao,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}