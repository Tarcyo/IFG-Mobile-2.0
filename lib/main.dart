import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/app/app_setup.dart';
import 'package:ifg_mobile_estudante/app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appConfig = await AppSetup.initialize();
  runApp(IFGApp(config: appConfig));
}