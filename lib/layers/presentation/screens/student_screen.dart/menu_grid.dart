import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/aluno_entity_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/notas_list_controller_provider.dart';
import 'package:ifg_mobile_estudante/core/utils/scroll_hint_banner.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/hor%C3%A1rio_de_aula_screen/hor%C3%A1rio_de_aula.dart';
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

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = size.width * 0.04;

    // Definindo os itens do menu utilizando o context atual.
    final List<Map<String, dynamic>> menuItems = [
      {
        'label': 'Horário de Aula',
        'icon': Icons.schedule_rounded,
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HorarioDeAulaScreen(),
              ),
            ),
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

          await notasControlerProvider.controller.getAlunoPorMatricula(
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
                              // Alteração para garantir contraste: texto com cor definida no AppColors.
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GradesScreen()),
            );
          }
        },
      },
      {
        'label': 'Meu Boletim',
        'icon': Icons.receipt_long_rounded,
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BoletimScreen()),
            ),
      },
      {
        'label': 'Material de Aula',
        'icon': Icons.menu_book_rounded,
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MaterialScreen()),
            ),
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
