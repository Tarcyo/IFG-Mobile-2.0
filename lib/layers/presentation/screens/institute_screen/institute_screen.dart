import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/core/utils/url_launcher_helper.dart';
import 'package:ifg_mobile_estudante/core/utils/scroll_hint_banner.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'menu_item.dart';
import 'screen_header.dart';
import 'system_buttom.dart';

class InstituteScreen extends StatefulWidget {
  const InstituteScreen({Key? key}) : super(key: key);

  @override
  _InstituteScreenState createState() => _InstituteScreenState();
}

class _InstituteScreenState extends State<InstituteScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollArrow = false;
  bool _bannerDismissed = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _handleScroll();
    });
  }

  void _handleScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    final shouldShow = maxScroll > 20 && currentScroll < maxScroll - 20;
    if (_showScrollArrow != shouldShow) {
      setState(() => _showScrollArrow = shouldShow);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // Dados dos itens do grid de menu com onTap
  List<Map<String, Object>> get menuItems => [
    {
      'label': 'Estude no\nIFG',
      'icon': Icons.school_rounded,
      'onTap': () async {
        await openWebPage("http://www.ifg.edu.br/estudenoifg");
      },
    },
    {
      'label': 'Reitoria',
      'icon': Icons.corporate_fare_rounded,
      'onTap': () async {
        await openWebPage("https://ifg.edu.br/reitoria");
      },
    },
    {
      'label': 'Projetos e\nProgramas',
      'icon': Icons.handyman_rounded,
      'onTap': () async {
        await openWebPage("https://ifg.edu.br/projetos-e-programas");
      },
    },
    {
      'label': 'Assistência\nEstudantil',
      'icon': Icons.volunteer_activism_rounded,
      'onTap': () async {
        await openWebPage("https://ifg.edu.br/assistencia-estudantil");
      },
    },

    {
      'label': 'Ouvidoria',
      'icon': Icons.campaign_rounded,
      'onTap': () async {
        await openWebPage("https://ifg.edu.br/ouvidoria");
      },
    },
    {
      'label': 'Mercado de\nTrabalho',
      'icon': Icons.work_rounded,
      'onTap': () async {
        await openWebPage("https://ifg.edu.br/egresso/");
      },
    },
    {
      'label': 'Dúvidas',
      'icon': Icons.help_center_rounded,
      'onTap': () async {
        await openWebPage("https://ifg.edu.br/perguntas-frequentes");
      },
    },
    {
      'label': 'Regulamento',
      'icon': Icons.rule_rounded,
      'onTap': () async {
        await openWebPage(
          "https://ifg.edu.br/conteudo-do-menu-superior/61-ifg/pro-reitorias/ensino/1568-regulamento-corpo-discente",
        );
      },
    },
    {
      'label': 'História',
      'icon': Icons.history_edu_rounded,
      'onTap': () async {
        await openWebPage(
          "https://www.ifg.edu.br/aluno/17-ifg/ultimas-noticias/10104-historia-do-ifg",
        );
      },
    },
    {
      'label': 'Mapa do IFG',
      'icon': Icons.map_outlined,
      'onTap': () async {
        await openWebPage("https://ifg.edu.br/campus");
      },
    },
    {
      'label': 'Guia de cursos',
      'icon': Icons.explore_rounded,
      'onTap': () async {
        await openWebPage("http://cursos.ifg.edu.br/");
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.04;
    final double verticalPadding = size.height * 0.02;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.mainGradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: ScreenHeader(
                      title: 'Instituição',
                      icon: Icons.account_balance_rounded,
                      iconColor: AppColors.solidBackgroundColor,
                      verticalPadding: verticalPadding,
                      avatarRadius: size.height * 0.07,
                      iconSize: size.height * 0.05,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: verticalPadding * 0.05,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SystemButton(
                              label:
                                  'Sistema Unificado de Administração Pública\n(SUAP)',
                              icon: Icons.business,
                              onTap: () async {
                                await openWebPage("https://suap.ifg.edu.br/");
                              },
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          Expanded(
                            child: SystemButton(
                              label:
                                  'Sistema\nIntegrado\nde\nBibliotecas\n(SIB/IFG)',
                              icon: Icons.local_library_rounded,
                              onTap: () async {
                                await openWebPage(
                                  "https://ifg.edu.br/bibliotecas?showall=&limitstart=",
                                );
                              },
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          Expanded(
                            child: SystemButton(
                              label:
                                  'Sistema de Eventos do\nInstituto\nFederal\n(Sugep)',
                              icon: Icons.event,
                              onTap: () async {
                                await openWebPage(
                                  "https://sugep.ifg.edu.br/eventos/#/home",
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: verticalPadding * 0.5,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: size.width * 0.02,
                        mainAxisSpacing: size.width * 0.02,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = menuItems[index];
                        return MenuItem(
                          icon: item['icon'] as IconData,
                          label: item['label'] as String,
                          onTap: item['onTap'] as VoidCallback,
                        );
                      }, childCount: menuItems.length),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: verticalPadding * 4),
                  ),
                ],
              ),
              if (_showScrollArrow && !_bannerDismissed)
                Positioned(
                  bottom: verticalPadding * 1.5,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ScrollHintBanner(
                      onDismissed: () {
                        setState(() {
                          _bannerDismissed = true;
                        });
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
