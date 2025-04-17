import 'package:ifg_mobile_estudante/layers/presentation/controllers/aluno_controller.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/notas_controler.dart';

class AppConfig {
  final bool autoLogin;
  final AlunoController alunoController;
  final NotasController notasController;

  AppConfig({
    required this.autoLogin,
    required this.alunoController,
    required this.notasController,
  });
}