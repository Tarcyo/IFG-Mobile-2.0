import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/boletim_controler.dart';

class AnosBoletimControllerProvider with ChangeNotifier {
  AnosBoletimController _controller;

  AnosBoletimControllerProvider(this._controller);

  // Getter para acessar o controlador
  AnosBoletimController get controller => _controller;

  // Método para substituir o controlador atual
  void setAnosBoletimController(AnosBoletimController c) {
    _controller = c;
    notifyListeners();  // Notifica os widgets ouvintes sobre a mudança
  }
}
