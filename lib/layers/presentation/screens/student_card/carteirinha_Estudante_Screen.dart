import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/student_card/back_card.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/student_card/front_card.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class CarteirinhaEstudanteScreen extends StatefulWidget {
  const CarteirinhaEstudanteScreen({Key? key}) : super(key: key);

  @override
  State<CarteirinhaEstudanteScreen> createState() =>
      _CarteirinhaEstudanteScreenState();
}

class _CarteirinhaEstudanteScreenState extends State<CarteirinhaEstudanteScreen>
    with SingleTickerProviderStateMixin {
  bool _isFront = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: pi).animate(_controller);
  }

  void _flipCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isFront = !_isFront;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double verticalPadding = size.height * 0.025;

    return Scaffold(
      backgroundColor: AppColors.solidBackgroundColor,
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          // Mantivemos a cor base do gradiente, mas utilizamos a cor centralizada para o fundo.
          gradient: LinearGradient(
            colors: [Color(0xFF004D40), AppColors.solidBackgroundColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Cabeçalho com botão de voltar e título
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: verticalPadding,
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadowColor,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Expanded(
                      child: Text(
                        'Carteira do Estudante',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(
                              blurRadius: 3,
                              color: Colors.black38,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.13),
                  ],
                ),
              ),
              // Corpo com o cartão animado
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: _flipCard,
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        final angle = _animation.value;
                        final isFrontVisible = angle < pi / 2;
                        return Transform(
                          transform:
                              Matrix4.identity()
                                ..setEntry(3, 2, 0.002)
                                ..rotateY(angle),
                          alignment: Alignment.center,
                          child:
                              isFrontVisible
                                  ? buildFrontCard(size)
                                  : Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(pi),
                                    child: buildBackCard(size),
                                  ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Instrução de toque
              Padding(
                padding: EdgeInsets.only(bottom: verticalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.touch_app, color: Colors.white70),
                    const SizedBox(width: 8),
                    Text(
                      'Toque para virar a carteirinha',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: size.width * 0.038,
                      ),
                    ),
                    // Caso deseje usar o estilo definido em card_text_style.dart, uma alternativa seria:
                    // style: cardTextStyle(size, fontSize: size.width * 0.038),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
