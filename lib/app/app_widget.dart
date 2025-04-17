import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/app/app_config_class.dart';
import 'package:ifg_mobile_estudante/app/app_providers.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/tabBar/main_tab_bar.dart';
import 'package:provider/provider.dart';

class IFGApp extends StatelessWidget {
  final AppConfig config;

  const IFGApp({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    _configureSystemUI();
    return MultiProvider(
      providers: getProviders(config),
      child: _buildMaterialApp(),
    );
  }

  void _configureSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.teal.shade900),
    );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  Widget _buildMaterialApp() {
    return MaterialApp(
      title: 'IFG Mobile Estudante',
      theme: _buildAppTheme(),
      debugShowCheckedModeBanner: false,
      home: const MainTabBar(),
    );
  }

  ThemeData _buildAppTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      fontFamily: "Quicksand",
    );
  }
}