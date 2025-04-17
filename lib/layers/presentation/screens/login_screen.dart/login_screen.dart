import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/already_auto_logged_bool_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/aluno_entity_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/will_auto_login_bool_Provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/login_screen.dart/on_login.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/student_screen.dart/student_screen.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'package:provider/provider.dart';
import 'login_header.dart';
import 'login_form.dart';
import 'login_buttom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController matriculaController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  FlutterSecureStorage? storage;

  bool lembrarDados = false;
  bool loginAutomatico = false;

@override
void initState() {
  super.initState();
  _scrollController.addListener(_handleScroll);
  _initAsync(); // Chama a função assíncrona separada
}

Future<void> _initAsync() async {
  storage = FlutterSecureStorage();

  bool remember = (await storage!.read(key: 'lembrar')) == 'true';

  if (remember) {
    matriculaController.text = await storage!.read(key: 'matricula') ?? "";
    senhaController.text = await storage!.read(key: 'senha') ?? "";
  }

  loginAutomatico = (await storage!.read(key: 'autoLogin')) == 'true';

  debugPrint('Matrícula: ${matriculaController.text}');
  debugPrint('Senha: ${senhaController.text}');
}

  void _handleScroll() {
    // Lógica futura de scroll pode ser adicionada aqui
  }

  @override
  void dispose() {
    _scrollController.dispose();
    matriculaController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final AlreadyAutoLogged alreadAutoLoggedProvider =
        Provider.of<AlreadyAutoLogged>(context);
    final AutoLoginProvider autoLoginProvider = Provider.of<AutoLoginProvider>(
      context,
    );

    if (autoLoginProvider.autoLogin &&
        !alreadAutoLoggedProvider.alreadAutoLogged) {
      final AlunoControllerProvider controlerProvider =
          Provider.of<AlunoControllerProvider>(context);
      alreadAutoLoggedProvider.setAlreadyAutoLogged(true);
      Future.microtask(() {
        if (controlerProvider.alunoController.aluno == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: AppColors.cardColor, // Cor de fundo do alerta
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Atenção",
                      style: TextStyle(
                        fontSize: screenWidth * 0.055,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor, // Cor do texto
                      ),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Falha ao tentar conectar.\nVerifique seus dados e tente novamente.",
                      style: TextStyle(
                        color:
                            AppColors
                                .descriptionColor, // Cor do texto secundário
                        fontSize: screenWidth * 0.032,
                      ),
                    ),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors
                                  .solidBackgroundColor, // Cor de fundo do botão
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(180.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Ok",
                          style: TextStyle(
                            color: AppColors.textColor, // Cor do texto do botão
                            fontSize: screenWidth * 0.032,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AlunoScreen()),
          );
        }
      });
    }

    final size = MediaQuery.of(context).size;
    final double paddingHorizontal = size.width * 0.08;
    final double paddingVertical = size.height * 0.05;

    return Scaffold(
      backgroundColor: AppColors.solidBackgroundColor, // Cor de fundo da tela
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.mainGradientColors, // Gradiente de fundo
            stops: [0.1, 0.5, 0.9],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal,
                vertical: paddingVertical,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoginHeader(logoAsset: 'assets/images/logo B.png'),
                  const SizedBox(height: 25),
                  LoginForm(
                    matriculaController: matriculaController,
                    senhaController: senhaController,
                    lembrarDados: lembrarDados,
                    loginAutomatico: loginAutomatico,
                    onLoginAutoChanged: (value) {
                      setState(() => loginAutomatico = value!);
                    },
                  ),
                  const SizedBox(height: 30),
                  LoginButton(
                    onLogin: () async {
                      onLogin(
                        context,
                        matriculaController,
                        senhaController,
                        size.height,
                        screenWidth,
                        storage,
                        loginAutomatico,
                      );
                    },
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
