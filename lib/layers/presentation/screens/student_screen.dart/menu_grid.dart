import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/aluno_entity_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/boletim_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/dia_da_semana_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/materiais_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/notas_list_controller_provider.dart';
import 'package:ifg_mobile_estudante/core/utils/scroll_hint_banner.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/horário_de_aula_screen/horário_de_aula.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/grade_screen/gradesScreen.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/report/boletim_screen.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/materiral_screen/material_screen.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'package:provider/provider.dart';
import 'menu_item.dart';

class MenuGrid extends StatelessWidget {
  final ScrollController scrollController;
  final Size size;
  final double verticalPadding;
  final bool bannerVisible;
  final VoidCallback onBannerDismissed;

  const MenuGrid({
    Key? key,
    required this.scrollController,
    required this.size,
    required this.verticalPadding,
    required this.bannerVisible,
    required this.onBannerDismissed,
  }) : super(key: key);

  void fadePush(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, animation, __) => page,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = size.width * 0.04;

    final List<Map<String, dynamic>> menuItems = [
      {
        'label': 'Horário de Aula',
        'icon': Icons.schedule_rounded,
        'onTap': () async {
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
                        color: AppColors.textColor,
                        fontSize: size.height * 0.035,
                      ),
                    ),
                    SizedBox(
                      width: size.height * 0.06,
                      height: size.height * 0.06,
                      child: CircularProgressIndicator(
                        strokeWidth: size.height * 0.01,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );

          final AlunoControllerProvider alunoProvider =
              Provider.of<AlunoControllerProvider>(context, listen: false);
          final DiasDaSemanaControllerProvider horarioDeAulaController =
              Provider.of<DiasDaSemanaControllerProvider>(context, listen: false);

          await horarioDeAulaController.controller.getDiasDaSemana(
            alunoProvider.alunoController.aluno!.getMatricula,
          );

          Navigator.of(context, rootNavigator: true).pop();

          if (horarioDeAulaController.controller.diasDaSemana == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: AppColors.solidBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Atenção",
                        style: TextStyle(
                          fontSize: size.width * 0.055,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Falha ao tentar conectar.",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: size.width * 0.032,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
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
                              color: AppColors.solidBackgroundColor,
                              fontSize: size.width * 0.032,
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
            fadePush(context, HorarioDeAulaScreen());
          }
        },
      },
      {
        'label': 'Minhas Notas',
        'icon': Icons.grade_rounded,
        'onTap': () async {
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
                        color: AppColors.textColor,
                        fontSize: size.height * 0.035,
                      ),
                    ),
                    SizedBox(
                      width: size.height * 0.06,
                      height: size.height * 0.06,
                      child: CircularProgressIndicator(
                        strokeWidth: size.height * 0.01,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );

          final AlunoControllerProvider alunoProvider =
              Provider.of<AlunoControllerProvider>(context, listen: false);
          final NotasControlerProvider notasControlerProvider =
              Provider.of<NotasControlerProvider>(context, listen: false);

          await notasControlerProvider.controller.getNotasDoAlunoPorMatricula(
            alunoProvider.alunoController.aluno!.getMatricula,
          );

          Navigator.of(context, rootNavigator: true).pop();

          if (notasControlerProvider.controller.notas == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: AppColors.solidBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Atenção",
                        style: TextStyle(
                          fontSize: size.width * 0.055,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Falha ao tentar conectar.",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: size.width * 0.032,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
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
                              color: AppColors.solidBackgroundColor,
                              fontSize: size.width * 0.032,
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
            fadePush(context, GradesScreen());
          }
        },
      },
      {
        'label': 'Meu Boletim',
        'icon': Icons.receipt_long_rounded,
        'onTap': () async {
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
                        color: AppColors.textColor,
                        fontSize: size.height * 0.035,
                      ),
                    ),
                    SizedBox(
                      width: size.height * 0.06,
                      height: size.height * 0.06,
                      child: CircularProgressIndicator(
                        strokeWidth: size.height * 0.01,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );

          final AlunoControllerProvider alunoProvider =
              Provider.of<AlunoControllerProvider>(context, listen: false);
          final AnosBoletimControllerProvider boletimControlerProvider =
              Provider.of<AnosBoletimControllerProvider>(context, listen: false);

          await boletimControlerProvider.controller.getAnosBoletim(
            alunoProvider.alunoController.aluno!.getMatricula,
          );

          Navigator.of(context, rootNavigator: true).pop();

          print("O boletim é: "+boletimControlerProvider.controller.anosBoletim.toString());

          if (boletimControlerProvider.controller.anosBoletim == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: AppColors.solidBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Atenção",
                        style: TextStyle(
                          fontSize: size.width * 0.055,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Falha ao tentar conectar.",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: size.width * 0.032,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
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
                              color: AppColors.solidBackgroundColor,
                              fontSize: size.width * 0.032,
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
            fadePush(context, BoletimScreen());
          }
        },
      },
      {
        'label': 'Material de Aula',
        'icon': Icons.menu_book_rounded,
        'onTap': () async {
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
                        color: AppColors.textColor,
                        fontSize: size.height * 0.035,
                      ),
                    ),
                    SizedBox(
                      width: size.height * 0.06,
                      height: size.height * 0.06,
                      child: CircularProgressIndicator(
                        strokeWidth: size.height * 0.01,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );

          final AlunoControllerProvider alunoProvider =
              Provider.of<AlunoControllerProvider>(context, listen: false);

          final DisciplinaMaterialControllerProvider materialPr =
              Provider.of<DisciplinaMaterialControllerProvider>(
                context,
                listen: false,
              );

          await materialPr.controller.getDisciplinasPorMatricula(
            alunoProvider.alunoController.aluno!.getMatricula,
          );
          print("chegou: " + materialPr.controller.disciplinas.toString());
          Navigator.of(context, rootNavigator: true).pop();

          if (materialPr.controller.disciplinas == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: AppColors.solidBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Atenção",
                        style: TextStyle(
                          fontSize: size.width * 0.055,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Falha ao tentar conectar.",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: size.width * 0.032,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
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
                              color: AppColors.solidBackgroundColor,
                              fontSize: size.width * 0.032,
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
            fadePush(context, MaterialScreen());
          }
        },
      },
    ];

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: GridView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(top: verticalPadding),
            itemCount: menuItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: size.width * 0.04,
              mainAxisSpacing: size.height * 0.02,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              final item = menuItems[index];
              return MenuItem(
                label: item['label'] ?? '',
                icon: item['icon'] ?? Icons.help,
                onTap: item['onTap'],
                size: size,
              );
            },
          ),
        ),
        if (bannerVisible)
          Positioned(
            bottom: verticalPadding,
            left: 0,
            right: 0,
            child: Center(
              child: ScrollHintBanner(onDismissed: onBannerDismissed),
            ),
          ),
      ],
    );
  }
}
