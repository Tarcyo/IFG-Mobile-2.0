import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/core/utils/scroll_hint_banner.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/rectory_message_screen/rectory_message_app_bar.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class ReitoriaMessageScreen extends StatelessWidget {
  final String reitorName;
  final String reitorImagePath;
  final String message;

  const ReitoriaMessageScreen({
    Key? key,
    required this.reitorName,
    required this.reitorImagePath,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.04;
    final verticalPadding = size.width * 0.04;

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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ReitoriaAppBar(),
                const SizedBox(height: 20),

                // Aqui, trocamos o Expanded direto por um Stack dentro do Expanded:
                Expanded(
                  child: Stack(
                    children: [
                      // O seu SingleChildScrollView original:
                      SingleChildScrollView(
                        child: ClipRRect(
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
                              border: Border.all(
                                color: AppColors.textColor,
                                width: 1.5,
                              ),
                            ),
                            padding: EdgeInsets.all(horizontalPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: size.width * 0.18,
                                  backgroundImage: AssetImage(reitorImagePath),
                                  backgroundColor: Colors.transparent,
                                ),
                                SizedBox(height: size.height * 0.02),
                                Text(
                                  reitorName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: size.width * 0.06,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: AppColors.shadowColor,
                                        blurRadius: 2,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "Reitora do IFG",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.descriptionColor,
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: AppColors.shadowColor,
                                        blurRadius: 2,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: size.height * 0.03),
                                Text(
                                  message,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: AppColors.textColor,
                                    fontSize: size.width * 0.04,
                                    fontStyle: FontStyle.italic,
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // E aqui posicionamos o hint na parte de baixo:
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(child: ScrollHintBanner()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
