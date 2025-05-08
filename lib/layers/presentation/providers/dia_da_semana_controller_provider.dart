import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/hor%C3%A1rio_controler.dart';

class DiasDaSemanaControllerProvider with ChangeNotifier {
  DiasDaSemanaController _controller;

  DiasDaSemanaControllerProvider(this._controller);

  // Getter para acessar o controlador
  DiasDaSemanaController get controller => _controller;

  // Método para substituir o controlador atual
  void setDiasDaSemanaController(DiasDaSemanaController c) {
    _controller = c;
    notifyListeners();  // Notifica os widgets ouvintes sobre a mudança
  }
}
