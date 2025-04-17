import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/aluno_controller.dart';

class AlunoControllerProvider with ChangeNotifier {
  AlunoController _alunoController;

  AlunoControllerProvider(this._alunoController);

  AlunoController get alunoController => _alunoController;

  void setAlunoControler(AlunoController c) {
    _alunoController = c;
    notifyListeners();
  }

  void logout() {
    this._alunoController.aluno = null;
    notifyListeners();
  }
}
