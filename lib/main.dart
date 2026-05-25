import 'package:app_projeto/controller/login_controller.dart';
import 'package:app_projeto/controller/paciente_controller.dart';

import 'package:app_projeto/view/cadastrar_view.dart';
import 'package:app_projeto/view/editar_paciente_view.dart';
import 'package:app_projeto/view/emcurso_view.dart';
import 'package:app_projeto/view/esqueceu_senha_view.dart';
import 'package:app_projeto/view/home_view.dart';
import 'package:app_projeto/view/login_view.dart';
import 'package:app_projeto/view/novo_view.dart';
import 'package:app_projeto/view/pesquisar_view.dart';
import 'package:app_projeto/view/resultado_view.dart';
import 'package:app_projeto/view/sobre_view.dart';
import 'package:app_projeto/view/visualizar_view.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:device_preview_plus/device_preview_plus.dart';

import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // GET IT
  GetIt g = GetIt.I;

  g.registerSingleton<LoginController>(
    LoginController(),
  );

  g.registerSingleton<PacienteController>(
    PacienteController(),
  );

  runApp(

    DevicePreview(
      enabled: true,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      useInheritedMediaQuery: true,

      locale: DevicePreview.locale(context),

      builder: DevicePreview.appBuilder,

      title: 'Chimeric',

      initialRoute: 'login',

      routes: {

        // LOGIN
        'login': (context) => const LoginView(),

        // CADASTRO
        'cadastrar': (context) =>
            const CadastrarView(),

        // ESQUECEU SENHA
        'esqueceuSenha': (context) =>
            const EsqueceuSenhaView(),

        // HOME
        'home': (context) => const HomeView(),

        // NOVO PACIENTE
        'novo': (context) => const NovoView(),

        // PESQUISAR
        'pesquisar': (context) =>
            const PesquisarView(),

        // EM CURSO
        'emcurso': (context) =>
            const EmCursoView(),

        // RESULTADO
        'resultado': (context) =>
            const ResultadoView(),

        // VISUALIZAR
        'visualizar': (context) =>
            const VisualizarView(),

        // SOBRE
        'sobre': (context) =>
            const SobreView(),

        // EDITAR
        'editar': (context) =>
            const EditarPacienteView(),
      },
    );
  }
}