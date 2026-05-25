import 'package:app_projeto/model/paciente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PacienteController extends ChangeNotifier {

  final FirebaseFirestore db =
      FirebaseFirestore.instance;

 
// ADICIONAR PACIENTE
 
  Future<void> adicionarPaciente(
    Paciente p,
  ) async {

    await db
        .collection('pacientes')
        .add(
          p.toJson(),
        );
  }

// LISTAR PACIENTES EM CURSO
  

  Stream<QuerySnapshot> listarPacientesEmCurso() {

    return db
        .collection('pacientes')

        .where(
          'status',
          isEqualTo: 'emcurso',
        )

        .orderBy(
          'inicio',
          descending: true,
        )

        .snapshots();
  }

 
// LISTAR TODOS PACIENTES


  Stream<QuerySnapshot> listarPacientes() {

    return db
        .collection('pacientes')

        .orderBy(
          'inicio',
          descending: true,
        )

        .snapshots();
  }

 
// PESQUISAR POR LOTE
  

  Stream<QuerySnapshot> pesquisarPorLote(
    String lote,
  ) {

    return db
        .collection('pacientes')

        .where(
          'loteBusca',
          isGreaterThanOrEqualTo:
              lote.toLowerCase(),
        )

        .where(
          'loteBusca',
          isLessThanOrEqualTo:
              '${lote.toLowerCase()}\uf8ff',
        )

        .snapshots();
  }


// FINALIZAR PACIENTE


  Future<void> finalizarPaciente(
    String id,
  ) async {

    await db
        .collection('pacientes')
        .doc(id)
        .update({

      'status': 'finalizado',
    });
  }
}