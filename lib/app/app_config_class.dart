import 'package:ifg_mobile_estudante/layers/presentation/controllers/aluno_controller.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/boletim_controler.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/hor%C3%A1rio_controler.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/material_controler.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/notas_controler.dart';

class AppConfig {
  final bool autoLogin;
  final AlunoController alunoController;
  final NotasController notasController;
  final DisciplinaMaterialController disciplinaController;
  final AnosBoletimController anosBoletimController;
  final DiasDaSemanaController diasDaSemanaController; // Adicionado

  AppConfig({
    required this.autoLogin,
    required this.alunoController,
    required this.notasController,
    required this.disciplinaController,
    required this.anosBoletimController,
    required this.diasDaSemanaController, // Inicializado
  });
}