import 'package:cloud_firestore/cloud_firestore.dart';

class Paciente {

  String? id;

  String lote;
  double peso;
  String doenca;

  Timestamp inicio;

  String status;

  Paciente({
    this.id,
    required this.lote,
    required this.peso,
    required this.doenca,
    required this.inicio,
    required this.status,
  });

  
// ENVIAR PARA FIRESTORE
 

  Map<String, dynamic> toJson() {

    return {

      'lote': lote,

      // CAMPO AUXILIAR PARA PESQUISA
      'loteBusca': lote.toLowerCase(),

      'peso': peso,

      'doenca': doenca,

      // CAMPO AUXILIAR PARA PESQUISA
      'doencaBusca': doenca.toLowerCase(),

      'inicio': inicio,

      'status': status,
    };
  }

  
// RECUPERAR DO FIRESTORE
  
  factory Paciente.fromJson(
    Map<String, dynamic> json,
    String docId,
  ) {

    return Paciente(

      id: docId,

      lote: json['lote'],

      peso: (json['peso'] as num).toDouble(),

      doenca: json['doenca'],

      inicio: json['inicio'],

      status: json['status'] ?? 'emcurso',
    );
  }
}