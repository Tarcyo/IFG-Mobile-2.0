import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/core/utils/scroll_hint_banner.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/dedication_screen.dart/dedication_footer.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/dedication_screen.dart/dedication_header.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart'; // Importa o AppColors

class DedicationScreen extends StatefulWidget {
  const DedicationScreen({Key? key}) : super(key: key);

  @override
  State<DedicationScreen> createState() => _DedicationScreenState();
}

class _DedicationScreenState extends State<DedicationScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showDownArrow = false;
  bool _bannerDismissed = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients &&
          _scrollController.position.maxScrollExtent > 0) {
        setState(() {
          _showDownArrow = true;
        });
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        final isAtBottom =
            _scrollController.offset >=
                _scrollController.position.maxScrollExtent ||
            _scrollController.position.maxScrollExtent == 0;

        setState(() {
          _showDownArrow =
              !isAtBottom && _scrollController.position.maxScrollExtent > 0;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.08;
    final double verticalPadding = size.height * 0.04;
    final double fontSize = size.width * 0.03;

    return Scaffold(
      backgroundColor: AppColors.solidBackgroundColor,
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.mainGradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              DedicationHeader(size: size, verticalPadding: verticalPadding),
              Expanded(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: _scrollController,
                      padding: EdgeInsets.only(bottom: size.height * 0.1),
                      child: Text(
                        'Com gratidão e carinho, dedico este aplicativo ao meu querido professor '
                        'Leandro Alexandre Freitas. Seu apoio constante, palavras encorajadoras e dedicação ao ensino '
                        'foram fundamentais não só para o sucesso deste projeto, mas também para fortalecer o meu sonho '
                        'de seguir na área acadêmica.\n\n'
                        'Obrigado por acreditar em mim e por iluminar o caminho com tanto conhecimento e inspiração.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.italic,
                          fontSize: fontSize,
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
                    if (_showDownArrow && !_bannerDismissed)
                      Positioned(
                        bottom: size.height * 0.1,
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
              DedicationFooter(size: size, verticalPadding: verticalPadding),
            ],
          ),
        ),
      ),
    );
  }
}
