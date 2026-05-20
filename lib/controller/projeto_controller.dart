import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// RESULTADO POR DIA

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

/// PACIENTE

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

  // =========================================
  // FIREBASE
  // =========================================

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // =========================================
  // LISTA DE PACIENTES
  // =========================================

  final List<Paciente> _pacientes = [];

  List<Paciente> get pacientes => _pacientes;

  // =========================================
  // ADICIONAR PACIENTE
  // =========================================

  void adicionarPaciente(Paciente p) {
    _pacientes.add(p);
    notifyListeners();
  }

  // =========================================
  // SALVAR RESULTADO
  // =========================================

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

  // =========================================
  // BUSCAR RESULTADO
  // =========================================

  ResultadoDia? getResultado(Paciente paciente, String dia) {
    return paciente.resultados[dia];
  }

  // =========================================
  // CAMPOS DE TEXTO
  // =========================================

  final txtNome = TextEditingController();
  final txtEmail = TextEditingController();
  final txtTelefone = TextEditingController();
  final txtSenha = TextEditingController();
  final txtConfirmarSenha = TextEditingController();
  final txtEmailEsqueceuSenha = TextEditingController();

  // =========================================
  // CONTROLE DE ESTADO
  // =========================================

  bool _lembrar = false;
  bool _notificar = false;

  // =========================================
  // GETTERS
  // =========================================

  bool get lembrar => _lembrar;
  bool get notificar => _notificar;

  // =========================================
  // SETTERS
  // =========================================

  void setLembrar(bool value) {
    _lembrar = value;
    notifyListeners();
  }

  void setNotificar(bool value) {
    _notificar = value;
    notifyListeners();
  }

  // =========================================
  // VALIDAÇÃO EMAIL
  // =========================================

  bool emailValido(String email) {
    return RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email);
  }

  // =========================================
  // VALIDAÇÃO SENHA
  // =========================================

  bool get senhasIguais =>
      txtSenha.text == txtConfirmarSenha.text;

  bool get senhaValida =>
      txtSenha.text.length >= 6;

  // =========================================
  // CRIAR CONTA
  // =========================================

  Future<void> criarConta(BuildContext context) async {

    try {

      UserCredential usuario =
          await auth.createUserWithEmailAndPassword(
        email: txtEmail.text.trim(),
        password: txtSenha.text.trim(),
      );

      // SALVAR DADOS NO FIRESTORE
      await db.collection('usuarios').doc(usuario.user!.uid).set({
        'uid': usuario.user!.uid,
        'nome': txtNome.text.trim(),
        'email': txtEmail.text.trim(),
        'telefone': txtTelefone.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Conta criada com sucesso!'),
        ),
      );

      limpar();

      Navigator.pushReplacementNamed(context, 'home');

    } on FirebaseAuthException catch (e) {

      String mensagem = 'Erro ao criar conta';

      switch (e.code) {

        case 'email-already-in-use':
          mensagem = 'Este e-mail já está em uso.';
          break;

        case 'invalid-email':
          mensagem = 'E-mail inválido.';
          break;

        case 'weak-password':
          mensagem =
              'A senha deve ter pelo menos 6 caracteres.';
          break;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagem)),
      );
    }
  }

  // =========================================
  // LOGIN
  // =========================================

  Future<void> login(BuildContext context) async {

    try {

      await auth.signInWithEmailAndPassword(
        email: txtEmail.text.trim(),
        password: txtSenha.text.trim(),
      );

      limpar();

      Navigator.pushReplacementNamed(context, 'home');

    } on FirebaseAuthException catch (e) {

      String mensagem = 'Erro ao fazer login';

      switch (e.code) {

        case 'invalid-email':
          mensagem = 'E-mail inválido.';
          break;

        case 'user-not-found':
          mensagem = 'Usuário não encontrado.';
          break;

        case 'wrong-password':
          mensagem = 'Senha incorreta.';
          break;

        case 'invalid-credential':
          mensagem = 'E-mail ou senha inválidos.';
          break;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagem)),
      );
    }
  }

  // =========================================
  // RECUPERAR SENHA
  // =========================================

  Future<void> esqueceuSenha(BuildContext context) async {

    try {

      await auth.sendPasswordResetEmail(
        email: txtEmailEsqueceuSenha.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'E-mail de recuperação enviado!',
          ),
        ),
      );

      txtEmailEsqueceuSenha.clear();

      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {

      String mensagem = 'Erro ao enviar e-mail';

      switch (e.code) {

        case 'invalid-email':
          mensagem = 'E-mail inválido.';
          break;

        case 'user-not-found':
          mensagem = 'Usuário não encontrado.';
          break;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagem)),
      );
    }
  }

  // =========================================
  // LOGOUT
  // =========================================

  Future<void> logout(BuildContext context) async {

    await auth.signOut();

    Navigator.pushReplacementNamed(context, 'login');
  }

  // =========================================
  // LIMPAR CAMPOS
  // =========================================

  void limpar() {

    txtNome.clear();
    txtEmail.clear();
    txtTelefone.clear();
    txtSenha.clear();
    txtConfirmarSenha.clear();
    txtEmailEsqueceuSenha.clear();

    _lembrar = false;
    _notificar = false;

    notifyListeners();
  }

  // =========================================
  // DISPOSE
  // =========================================

  @override
  void dispose() {

    txtNome.dispose();
    txtEmail.dispose();
    txtTelefone.dispose();
    txtSenha.dispose();
    txtConfirmarSenha.dispose();
    txtEmailEsqueceuSenha.dispose();

    super.dispose();
  }
}