import 'package:app_projeto/model/paciente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PesquisarView extends StatefulWidget {
  const PesquisarView({super.key});

  @override
  State<PesquisarView> createState() =>
      _PesquisarViewState();
}

class _PesquisarViewState
    extends State<PesquisarView> {

  final txtPesquisa = TextEditingController();

  // PESO
  final txtPesoMin = TextEditingController();
  final txtPesoMax = TextEditingController();

  String ordenarPor = 'inicio';

  // TIPO PESQUISA
  String tipoPesquisa = 'lote';

  @override
  void dispose() {

    txtPesquisa.dispose();

    txtPesoMin.dispose();
    txtPesoMax.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Pesquisar Pacientes'),
        backgroundColor: Colors.green[700],
      ),

      body: Column(
        children: [

        
          // TIPO PESQUISA
       

          Padding(

            padding: const EdgeInsets.all(15),

            child: DropdownButtonFormField<String>(

              value: tipoPesquisa,

              decoration: InputDecoration(

                labelText: 'Pesquisar por',

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),

              items: const [

                DropdownMenuItem(
                  value: 'lote',
                  child: Text('Lote'),
                ),

                DropdownMenuItem(
                  value: 'doenca',
                  child: Text('Doença'),
                ),

                DropdownMenuItem(
                  value: 'peso',
                  child: Text('Peso'),
                ),
              ],

              onChanged: (value) {

                setState(() {

                  tipoPesquisa = value!;

                  txtPesquisa.clear();

                  txtPesoMin.clear();
                  txtPesoMax.clear();
                });
              },
            ),
          ),

          
          // CAMPO TEXTO
          

          if (tipoPesquisa != 'peso')

            Padding(

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 15,
              ),

              child: TextField(

                controller: txtPesquisa,

                decoration: InputDecoration(

                  hintText:
                      tipoPesquisa == 'lote'
                          ? 'Pesquisar lote'
                          : 'Pesquisar doença',

                  prefixIcon:
                      const Icon(Icons.search),

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),

                onChanged: (value) {

                  setState(() {});
                },
              ),
            ),

         
          // PESQUISA POR PESO
          

          if (tipoPesquisa == 'peso')

            Padding(

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 15,
              ),

              child: Row(
                children: [

                  Expanded(

                    child: TextField(

                      controller: txtPesoMin,

                      keyboardType:
                          TextInputType.number,

                      decoration: InputDecoration(

                        labelText:
                            'Peso mínimo',

                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                                  12),
                        ),
                      ),

                      onChanged: (value) {

                        setState(() {});
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(

                    child: TextField(

                      controller: txtPesoMax,

                      keyboardType:
                          TextInputType.number,

                      decoration: InputDecoration(

                        labelText:
                            'Peso máximo',

                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                                  12),
                        ),
                      ),

                      onChanged: (value) {

                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 10),

          
          // ORDENAÇÃO
        

          Padding(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 15,
            ),

            child: DropdownButtonFormField<String>(

              value: ordenarPor,

              decoration: InputDecoration(

                labelText: 'Ordenar por',

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),

              items: const [

                DropdownMenuItem(
                  value: 'inicio',
                  child:
                      Text('Data de início'),
                ),

                DropdownMenuItem(
                  value: 'lote',
                  child: Text('Lote'),
                ),

                DropdownMenuItem(
                  value: 'doenca',
                  child: Text('Doença'),
                ),

                DropdownMenuItem(
                  value: 'peso',
                  child: Text('Peso'),
                ),
              ],

              onChanged: (value) {

                setState(() {

                  ordenarPor = value!;
                });
              },
            ),
          ),

          const SizedBox(height: 10),

         
          // LISTA
          

          Expanded(

            child:
                StreamBuilder<QuerySnapshot>(

              stream: FirebaseFirestore.instance
                  .collection('pacientes')
                  .orderBy(
                    ordenarPor,
                    descending:
                        ordenarPor == 'inicio',
                  )
                  .snapshots(),

              builder: (context, snapshot) {

                // ERRO
                if (snapshot.hasError) {

                  return const Center(
                    child: Text(
                      'Erro ao carregar dados',
                    ),
                  );
                }

                // CARREGANDO
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {

                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                // SEM DADOS
                if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {

                  return const Center(
                    child: Text(
                      'Nenhum paciente encontrado',
                    ),
                  );
                }

                final dados =
                    snapshot.data!.docs;

                String pesquisa =
                    txtPesquisa.text
                        .toLowerCase();

                // FILTRO
                final filtrados =
                    dados.where((doc) {

                  final item =
                      doc.data()
                          as Map<String, dynamic>;

                  final lote =
                      item['loteBusca']
                          .toString();

                  final doenca =
                      item['doencaBusca']
                          .toString();

                  double pesoPaciente =
                      (item['peso'] as num)
                          .toDouble();

                
                  // LOTE
                  

                  if (tipoPesquisa ==
                      'lote') {

                    return lote.contains(
                      pesquisa,
                    );
                  }

               
                  // DOENÇA
                  

                  if (tipoPesquisa ==
                      'doenca') {

                    return doenca.contains(
                      pesquisa,
                    );
                  }

               
                  // PESO
                  

                  if (tipoPesquisa ==
                      'peso') {

                    double pesoMin =
                        double.tryParse(
                              txtPesoMin.text
                                  .replaceAll(
                                      ',', '.'),
                            ) ??
                            0;

                    double pesoMax =
                        double.tryParse(
                              txtPesoMax.text
                                  .replaceAll(
                                      ',', '.'),
                            ) ??
                            999999;

                    return pesoPaciente >=
                            pesoMin &&
                        pesoPaciente <=
                            pesoMax;
                  }

                  return false;

                }).toList();

                // SEM RESULTADO
                if (filtrados.isEmpty) {

                  return const Center(
                    child: Text(
                      'Nenhum resultado encontrado',
                    ),
                  );
                }

                return ListView.builder(

                  itemCount:
                      filtrados.length,

                  itemBuilder:
                      (context, index) {

                    final doc =
                        filtrados[index];

                    final item =
                        doc.data()
                            as Map<String, dynamic>;

                    final paciente =
                        Paciente.fromJson(
                      item,
                      doc.id,
                    );

                    DateTime data =
                        paciente.inicio
                            .toDate();

                    return Card(

                      margin:
                          const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),

                      child: ListTile(

                        leading: const Icon(
                          Icons.person,
                        ),

                        title: Text(
                          'Lote: ${paciente.lote}',
                        ),

                        subtitle: Text(

                          'Doença: ${paciente.doenca}'
                          '\n'
                          'Peso: ${paciente.peso} Kg'
                          '\n'
                          'Início: '
                          '${data.day.toString().padLeft(2, '0')}/'
                          '${data.month.toString().padLeft(2, '0')}/'
                          '${data.year}',
                        ),

                        isThreeLine: true,

                        trailing:
                            PopupMenuButton(

                          itemBuilder:
                              (context) => [

                            const PopupMenuItem(
                              value:
                                  'visualizar',
                              child: Text(
                                'Visualizar',
                              ),
                            ),

                            const PopupMenuItem(
                              value:
                                  'editar',
                              child: Text(
                                'Editar',
                              ),
                            ),

                            const PopupMenuItem(
                              value:
                                  'excluir',
                              child: Text(
                                'Excluir',
                              ),
                            ),
                          ],

                          onSelected:
                              (value) async {

                            // VISUALIZAR
                            if (value ==
                                'visualizar') {

                              Navigator
                                  .pushNamed(

                                context,

                                'visualizar',

                                arguments:
                                    paciente,
                              );
                            }

                            // EDITAR
                            if (value ==
                                'editar') {

                              Navigator
                                  .pushNamed(

                                context,

                                'editar',

                                arguments:
                                    paciente,
                              );
                            }

                            // EXCLUIR
                            if (value ==
                                'excluir') {

                              try {

                               
                                // EXCLUIR RESULTADOS
                              

                                final resultados =
                                    await FirebaseFirestore
                                        .instance
                                        .collection(
                                            'resultados')
                                        .where(
                                          'idPaciente',
                                          isEqualTo:
                                              paciente.id,
                                        )
                                        .get();

                                for (var docResultado
                                    in resultados.docs) {

                                  await FirebaseFirestore
                                      .instance
                                      .collection(
                                          'resultados')
                                      .doc(
                                          docResultado.id)
                                      .delete();
                                }

                                // EXCLUIR PACIENTE
                               

                                await FirebaseFirestore
                                    .instance
                                    .collection(
                                        'pacientes')
                                    .doc(paciente.id)
                                    .delete();

                                // SUCESSO

                                ScaffoldMessenger.of(
                                        context)
                                    .showSnackBar(

                                  const SnackBar(
                                    content: Text(
                                      'Paciente excluído com sucesso!',
                                    ),
                                  ),
                                );

                              } catch (e) {

                                ScaffoldMessenger.of(
                                        context)
                                    .showSnackBar(

                                  SnackBar(
                                    content: Text(
                                      'Erro ao excluir: $e',
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}