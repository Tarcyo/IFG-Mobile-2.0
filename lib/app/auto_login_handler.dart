import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/aluno_controller.dart';

class AutoLoginHandler {
  static Future<bool> checkAutoLogin() async {
    final storage = FlutterSecureStorage();
    return (await storage.read(key: 'autoLogin')) == 'true';
  }

  static Future<void> performAutoLogin() async {
    final storage = FlutterSecureStorage();
    final alunoController = GetIt.instance.get<AlunoController>();
    final matricula = await storage.read(key: 'matricula') ?? "";
    await alunoController.getAlunoPorMatricula(matricula);
  }
}