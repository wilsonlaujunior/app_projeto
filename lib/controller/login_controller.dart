import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {

  // CAMPOS DE TEXTO

  final txtNome = TextEditingController();
  final txtEmail = TextEditingController();
  final txtTelefone = TextEditingController();
  final txtSenha = TextEditingController();
  final txtConfirmarSenha = TextEditingController();
  final txtEmailEsqueceuSenha = TextEditingController();

  // FIREBASE

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // CONTROLES

  bool _notificar = false;

  bool get notificar => _notificar;

  void setNotificar(bool value) {
    _notificar = value;
    notifyListeners();
  }

  // VALIDAR EMAIL

  bool emailValido(String email) {
    return RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email);
  }

  // CRIAR CONTA

  Future<void> criarConta(context) async {

    try {

      UserCredential usuario =
          await auth.createUserWithEmailAndPassword(
        email: txtEmail.text,
        password: txtSenha.text,
      );

  // SALVAR DADOS NO FIRESTORE

      await db.collection('usuarios').doc(usuario.user!.uid).set({
        'uid': usuario.user!.uid,
        'nome': txtNome.text,
        'email': txtEmail.text,
        'telefone': txtTelefone.text,
      });

  // MENSAGEM DE SUCESSO

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Conta criada com sucesso!'),
          duration: Duration(seconds: 2),
        ),
      );

      limpar();

  // REDIRECIONAR PARA LOGIN

      Future.delayed(const Duration(seconds: 2), () {

        Navigator.pushReplacementNamed(
          context,
          'login',
        );

      });

    } on FirebaseAuthException catch (e) {

      String mensagem;

      switch (e.code) {

        case 'email-already-in-use':
          mensagem = 'Este e-mail já está em uso.';
          break;

        case 'invalid-email':
          mensagem = 'E-mail inválido.';
          break;

        case 'weak-password':
          mensagem =
              'A senha deve conter pelo menos 6 caracteres.';
          break;

        default:
          mensagem = 'Erro: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagem)),
      );
    }
  }

  // LOGIN

  Future<void> login(context) async {

    try {

      await auth.signInWithEmailAndPassword(
        email: txtEmail.text,
        password: txtSenha.text,
      );

      limpar();

      Navigator.pushReplacementNamed(context, 'home');

    } on FirebaseAuthException catch (e) {

      String mensagem;

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
          mensagem = 'E-mail ou senha incorretos.';
          break;

        default:
          mensagem = 'Erro: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagem)),
      );
    }
  }

  // RECUPERAR SENHA

  Future<void> esqueceuSenha(context) async {

    try {

      await auth.sendPasswordResetEmail(
        email: txtEmailEsqueceuSenha.text,
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

      String mensagem;

      switch (e.code) {

        case 'invalid-email':
          mensagem = 'E-mail inválido.';
          break;

        case 'user-not-found':
          mensagem = 'Usuário não encontrado.';
          break;

        default:
          mensagem = 'Erro: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagem)),
      );
    }
  }

  // LOGOUT

  Future<void> logout(context) async {

    await auth.signOut();

    Navigator.pushReplacementNamed(context, 'login');
  }

  // LIMPAR CAMPOS

  void limpar() {

    txtNome.clear();
    txtEmail.clear();
    txtTelefone.clear();
    txtSenha.clear();
    txtConfirmarSenha.clear();
    txtEmailEsqueceuSenha.clear();

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
    txtEmailEsqueceuSenha.dispose();

    super.dispose();
  }
}