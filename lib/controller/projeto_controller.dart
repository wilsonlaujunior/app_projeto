import 'package:flutter/material.dart';


/// RESULTADO POR DIA)

class ResultadoDia {
  double concentracao;
  double volume;
  double cart;
  double totalCelulas;
  double totalCart;

  ResultadoDia({
    required this.concentracao,
    required this.volume,
    required this.cart,
    required this.totalCelulas,
    required this.totalCart,
  });
}


/// PACIENTE)

class Paciente {
  String lote;
  String peso;
  String doenca;
  String data;

  // RESULTADOS POR DIA
  Map<String, ResultadoDia> resultados = {};

  Paciente({
    required this.lote,
    required this.peso,
    required this.doenca,
    required this.data,
  });
}


/// CONTROLLER

class ProjetoController extends ChangeNotifier {


  // LISTA DE PACIENTES/LOTES
  
  final List<Paciente> _pacientes = [];

  List<Paciente> get pacientes => _pacientes;

 
  // ADICIONAR PACIENTE
  
  void adicionarPaciente(Paciente p) {
    _pacientes.add(p);
    notifyListeners();
  }

 
  // SALVAR RESULTADO DO DIA

  void salvarResultado({
    required Paciente paciente,
    required String dia,
    required double concentracao,
    required double volume,
    required double cart,
  }) {

    double totalCelulas = concentracao * volume;
    double totalCart = (cart / 100) * totalCelulas;

    paciente.resultados[dia] = ResultadoDia(
      concentracao: concentracao,
      volume: volume,
      cart: cart,
      totalCelulas: totalCelulas,
      totalCart: totalCart,
    );

    notifyListeners();
  }


  // BUSCAR RESULTADO
  
  ResultadoDia? getResultado(Paciente paciente, String dia) {
    return paciente.resultados[dia];
  }


  // CAMPOS DE TEXTO

  final txtNome  = TextEditingController();
  final txtEmail = TextEditingController();
  final txtTelefone = TextEditingController();
  final txtSenha = TextEditingController();
  final txtConfirmarSenha = TextEditingController();


  // CONTROLE DE ESTADO
 
  bool _lembrar = false;
  bool _notificar = false;


  // GETTERS

  bool get lembrar => _lembrar;
  bool get notificar => _notificar;


  // SETTERS

  void setLembrar(bool value){
    _lembrar = value;
    notifyListeners();
  }

  void setNotificar(bool value){
    _notificar = value;
    notifyListeners();
  }


  // VALIDAÇÃO EMAIL

  bool emailValido(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(email);
  }

 
  // VALIDAÇÃO SENHA
  
  bool get senhasIguais =>
      txtSenha.text == txtConfirmarSenha.text;

  bool get senhaValida =>
      txtSenha.text.length >= 6;


  // LIMPAR CAMPOS
 
  void limpar(){
    txtNome.clear();
    txtEmail.clear();
    txtTelefone.clear();
    txtSenha.clear();
    txtConfirmarSenha.clear();
    _lembrar = false;
    _notificar = false;
    notifyListeners();
  }

  
  // DISPOSE

  @override
  void dispose() {
    txtNome.dispose();
    txtEmail.dispose();
    txtTelefone.dispose();
    txtSenha.dispose();
    txtConfirmarSenha.dispose();
    super.dispose();
  }
}