import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/aluno_entity_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/student_screen.dart/student_screen.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'package:provider/provider.dart';

void onLogin(
  context,
  matriculaController,
  senhaController,
  screenHeight,
  screenWidth,
  storage,
  autoLogin,
) async {
  print("auto login? "+autoLogin.toString());
  print("AAAAAAAAAAAAAAA");
  if (matriculaController.text.isEmpty) {
    return;
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Carregando...",
              style: TextStyle(
                color: AppColors.textColor, // Cor do texto
                fontSize: screenHeight * 0.035,
              ),
            ),
            SizedBox(
              width: screenHeight * 0.06,
              height: screenHeight * 0.06,
              child: CircularProgressIndicator(
                strokeWidth: screenHeight * 0.01, // Espessura da linha
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.textColor), // Cor da progress indicator
              ),
            ),
          ],
        ),
      );
    },
  );

  final alunoController =
      Provider.of<AlunoControllerProvider>(
        context,
        listen: false,
      ).alunoController;

  await alunoController.getAlunoPorMatricula(matriculaController.text);

  if (autoLogin) {
    await storage.write(key: 'autoLogin', value: autoLogin.toString());
    await storage.write(key: 'matricula', value: matriculaController.text);
    await storage.write(key: 'senha', value: senhaController.text);
  } else {
    await storage.delete(key: 'autoLogin');
  }

  Navigator.of(context, rootNavigator: true).pop();

  print("dados:" + alunoController.aluno.toString());

  if (alunoController.aluno == null) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          contentPadding: EdgeInsets.zero,
          content: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.mainGradientColors, // Usando gradiente de cores
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(32.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor, // Cor da sombra
                  blurRadius: 10,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            padding: EdgeInsets.all(screenWidth * 0.045),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Título
                Text(
                  "Atenção",
                  style: TextStyle(
                    fontSize: screenWidth * 0.055,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor, // Cor do texto
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.02),
                // Mensagem de erro
                Text(
                  "Falha ao tentar conectar.\nVerifique seus dados e tente novamente.",
                  style: TextStyle(
                    color: AppColors.descriptionColor, // Cor do texto secundário
                    fontSize: screenWidth * 0.032,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.03),
                // Botão "Ok"
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.solidBackgroundColor, // Cor do fundo do botão
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AlunoScreen()),
    );
  }
}
