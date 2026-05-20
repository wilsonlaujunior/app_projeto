import 'package:app_projeto/view/emcurso_view.dart';
import 'package:app_projeto/view/novo_view.dart';
import 'package:app_projeto/view/resultado_view.dart';
import 'package:app_projeto/view/visualizar_view.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'controller/projeto_controller.dart';
import 'controller/login_controller.dart';

import 'view/login_view.dart';
import 'view/cadastrar_view.dart';
import 'view/exibir_view.dart';
import 'view/esqueceu_senha_view.dart';
import 'view/home_view.dart';
import 'view/sobre_view.dart';

final g = GetIt.instance;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // FIREBASE
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // CONTROLLER PRINCIPAL
  g.registerSingleton<ProjetoController>(
    ProjetoController(),
  );

  // CONTROLLER LOGIN
  g.registerSingleton<LoginController>(
    LoginController(),
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

      title: 'Chimeric',

      // DEVICE PREVIEW
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      // TELA INICIAL
      initialRoute: 'login',

      routes: {

        // LOGIN
        'login': (context) => const LoginView(),

        // CADASTRO
        'cadastrar': (context) => CadastrarView(),

        // EXIBIR
        'exibir': (context) => ExibirView(),

        // RECUPERAR SENHA
        'senha': (context) => EsqueceuSenhaView(),

        // HOME
        'home': (context) => HomeView(),

        // SOBRE
        'sobre': (context) => SobreView(),

        // NOVO PACIENTE
        'novo': (context) => NovoView(),

        // EM CURSO
        'emcurso': (context) => EmCursoView(),

        // VISUALIZAR LOTE
        'visualizar': (context) => VisualizarView(),

        // RESULTADOS
        'resultado': (context) => ResultadoView(),
      },
    );
  }
}