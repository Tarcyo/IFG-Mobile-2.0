import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/material_controler.dart';

class DisciplinaMaterialControllerProvider with ChangeNotifier {
  DisciplinaMaterialController _controller;

  DisciplinaMaterialControllerProvider(this._controller);

  // Getter para acessar o controlador
  DisciplinaMaterialController get controller => _controller;

  // Método para substituir o controlador atual
  void setDisciplinaMaterialController(DisciplinaMaterialController c) {
    _controller = c;
    notifyListeners();  // Notifica os widgets ouvintes sobre a mudança
  }
}