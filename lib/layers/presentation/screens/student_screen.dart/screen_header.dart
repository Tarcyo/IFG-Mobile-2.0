import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/core/utils/get_student_first_name_helper.dart';
import 'package:ifg_mobile_estudante/core/utils/get_time_of_the_day_helper.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/aluno_entity_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'package:provider/provider.dart';
import 'button_painter.dart';

class HeaderWidget extends StatelessWidget {
  final Size size;

  const HeaderWidget({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = size.width * 0.04;

    return Stack(
      children: [
        Container(
          height: size.height * 0.23,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: AppColors.mainGradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: CustomPaint(
            painter: ButtonPainter(),
            size: Size(double.infinity, size.height * 0.18),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(horizontalPadding * 0.8),
          child: Row(
            children: [
              Consumer<AlunoControllerProvider>(
                builder: (context, provider, child) {
                  final aluno = provider.alunoController.aluno;
                  if (aluno == null) {
                    return CircleAvatar(
                      radius: size.height * 0.09,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(
                        Icons.person,
                        size: size.height * 0.07,
                        color: Colors.white,
                      ),
                    );
                  }
                  final avatarUrl = aluno.getFullImageUrl;
                  return CircleAvatar(
                    radius: size.height * 0.09,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: avatarUrl != null && avatarUrl.isNotEmpty
                          ? Image.network(
                              avatarUrl,
                              fit: BoxFit.cover,
                              width: size.height * 0.25,
                              height: size.height * 0.25,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.error,
                                size: size.height * 0.07,
                                color: AppColors.alertColor,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: size.height * 0.07,
                              color: AppColors.descriptionColor,
                            ),
                    ),
                  );
                },
              ),
              SizedBox(width: horizontalPadding),
              Expanded(
                child: Consumer<AlunoControllerProvider>(
                  builder: (context, provider, child) {
                    final aluno = provider.alunoController.aluno;
                    final nomeCompleto = aluno?.getNome;
                    final primeiroNome = nomeCompleto != null && nomeCompleto.isNotEmpty
                        ? primeiroNomeDoAluno(nomeCompleto)
                        : 'Aluno';
                    final matricula = aluno?.getMatricula ?? '---';
                    final situacao = aluno?.getSituacao ?? '---';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${comprimentoDaHora()} $primeiroNome!',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: size.width * 0.039,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: size.width * 0.01),
                        Text(
                          'Matrícula: $matricula',
                          style: TextStyle(
                            color: AppColors.descriptionColor,
                            fontSize: size.width * 0.029,
                          ),
                        ),
                        Text(
                          'Situação: $situacao',
                          style: TextStyle(
                            color: AppColors.descriptionColor,
                            fontSize: size.width * 0.029,
                          ),
                        ),
                        Text(
                          'Nome: ${nomeCompleto ?? '---'}',
                          style: TextStyle(
                            color: AppColors.descriptionColor,
                            fontSize: size.width * 0.029,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: Icon(
              Icons.logout,
              color: AppColors.textColor,
              size: size.width * 0.1,
            ),
            onPressed: () {
              showDialog<bool>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: AppColors.cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.logout,
                          size: 50,
                          color: AppColors.solidBackgroundColor,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Deseja sair?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                    content: Text(
                      'Você tem certeza que deseja sair da sua conta?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.descriptionColor,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.solidBackgroundColor,
                        ),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.solidBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Sair',
                          style: TextStyle(color: AppColors.buttonTextColor),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  );
                },
              ).then((confirmed) {
                if (confirmed == true) {
                  Provider.of<AlunoControllerProvider>(context, listen: false).logout();
                  Navigator.of(context).pop();
                }
              });
            },
          ),
        ),
      ],
    );
  }
}