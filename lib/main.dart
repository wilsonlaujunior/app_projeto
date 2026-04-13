import 'package:app_projeto/view/emcurso_view.dart';
import 'package:app_projeto/view/novo_view.dart';
import 'package:app_projeto/view/resultado_view.dart';
import 'package:app_projeto/view/visualizar_view.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'controller/projeto_controller.dart';
import 'view/login_view.dart';
import 'view/cadastrar_view.dart';
import 'view/exibir_view.dart';
import 'view/esqueceu_senha_view.dart';
import 'view/home_view.dart';
import 'view/sobre_view.dart';


final g = GetIt.instance;

void main() {
  g.registerSingleton<ProjetoController>(
    ProjetoController(),
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
      title: 'NavigatorApp',

      initialRoute: 'login',
      routes: {
        'login': (context) => LoginView(),
        'cadastrar': (context) => CadastrarView(),
        'exibir': (context) => ExibirView(),
        'senha' : (context) =>  EsqueceuSenhaView(),
        'home' : (context) => HomeView(),
        'sobre' : (context) => SobreView(),
        'novo' : (context) => NovoView(),
        'emcurso': (context) => EmCursoView(),
        'visualizar': (context) => VisualizarView(),
        'resultado' : (context) => ResultadoView(),
      },
    );
  }
}