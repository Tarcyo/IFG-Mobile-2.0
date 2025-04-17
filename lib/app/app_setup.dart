import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:ifg_mobile_estudante/app/app_config_class.dart';
import 'package:ifg_mobile_estudante/core/inject/inject.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/aluno_controller.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/notas_controler.dart';

class AppSetup {
  static Future<AppConfig> initialize() async {
    await _loadEnvironmentVariables();
    _setupDependencyInjection();
    return _handleAutoLogin();
  }

  static Future<void> _loadEnvironmentVariables() async {
    await dotenv.load(fileName: ".env");
  }

  static void _setupDependencyInjection() {
    Inject.init();
  }

  static Future<AppConfig> _handleAutoLogin() async {
    final storage = FlutterSecureStorage();
    final autoLogin = (await storage.read(key: 'autoLogin')) == 'true';
    final alunoController = GetIt.instance.get<AlunoController>();
    final notasController = GetIt.instance.get<NotasController>();

    if (autoLogin) {
      final matricula = await storage.read(key: 'matricula') ?? "";
      await alunoController.getAlunoPorMatricula(matricula);
    }

    return AppConfig(
      autoLogin: autoLogin,
      alunoController: alunoController,
      notasController: notasController,
    );
  }
}

