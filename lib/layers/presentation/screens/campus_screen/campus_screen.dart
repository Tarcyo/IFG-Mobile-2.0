import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/core/utils/remove_special_icons_for_URL_helper.dart';
import 'package:ifg_mobile_estudante/core/utils/url_launcher_helper.dart';
import 'package:ifg_mobile_estudante/core/utils/scroll_hint_banner.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'menu_item_button.dart';
import 'screen_header.dart';

class CampusScreen extends StatefulWidget {
  final Map<String, dynamic> dados;
  final String name;
  const CampusScreen({required this.name, required this.dados, Key? key})
    : super(key: key);

  @override
  State<CampusScreen> createState() => _CampusScreenState();
}

class _CampusScreenState extends State<CampusScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollArrow = false;
  bool _bannerDismissed = false; 

  List<Map<String, dynamic>> get menuItems => [
    {
      'label': 'Telefones',
      'icon': Icons.phone_rounded,
      'onTap':
          () async => await openWebPage(
            'http://www.ifg.edu.br/' +
                removerAcentosParaUrl(widget.name) +
                "/contato",
          ),
    },
    {
      'label': 'Localização',
      'icon': Icons.location_on_rounded,
      'onTap':
          () async => await openWebPage(
            widget.dados['campus'][widget.name]['localização'],
          ),
    },
    {
      'label': 'Facebook',
      'icon': Icons.facebook,
      'onTap':
          () async => await openWebPage(
            widget.dados['campus'][widget.name]['facebook'],
          ),
    },
    {
      'label': 'Instagram',
      'icon': Icons.camera_alt_rounded,
      'onTap':
          () async => await openWebPage(
            widget.dados['campus'][widget.name]['instagram'],
          ),
    },
  ];

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.04;

    return Scaffold(
      backgroundColor: AppColors.solidBackgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.mainGradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  CustomAppBar(title: widget.name),

                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      padding: EdgeInsets.only(
                        left: padding,
                        right: padding,
                        top: padding * 0.5,
                        bottom: padding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: AppColors.screenBackgroundGradient,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.shadowColor,
                                    blurRadius: 8,
                                    offset: Offset(2, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/' + widget.name + ".jpg",
                                    height: size.height * 0.20,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(padding * 0.8),
                                    child: Text(
                                      widget.dados['campus'][widget
                                          .name]['descrição'],
                                            textAlign: TextAlign.start,  

                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontStyle: FontStyle.italic,
                                        fontSize: size.width * 0.035,
                                        color: AppColors.textColor,
                                        
                                        height: 1.6,
                                        shadows: const [
                                          Shadow(
                                            color: AppColors.shadowColor,
                                            offset: Offset(0.5, 0.5),
                                            blurRadius: 1.5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: padding,
                            crossAxisSpacing: padding,
                            childAspectRatio: 1.0,
                            children:
                                menuItems.map((item) {
                                  return MenuItem(
                                    label: item['label'],
                                    icon: item['icon'],
                                    onTap: item['onTap'],
                                  );
                                }).toList(),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () async {
                              await openWebPage(
                                'http://www.ifg.edu.br/' +
                                    removerAcentosParaUrl(widget.name),
                              );
                            },
                            child: Container(
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: AppColors.screenBackgroundGradient,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.buttonShadowColor,
                                    blurRadius: 6,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                                border: Border.all(
                                  color: AppColors.textColor,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.public,
                                    color: AppColors.textColor,
                                    size: size.height * 0.04,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Página do Campus',
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.04,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (!_bannerDismissed && _showScrollArrow)
                Positioned(
                  bottom: padding * 1.5,
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
