import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class ScrollHintBanner extends StatefulWidget {
  final VoidCallback? onDismissed;

  const ScrollHintBanner({super.key, this.onDismissed});

  @override
  State<ScrollHintBanner> createState() => _ScrollHintBannerState();
}

class _ScrollHintBannerState extends State<ScrollHintBanner> 
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..repeat(reverse: true);

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _triggerDismiss();
    });
  }

  void _triggerDismiss() {
    setState(() => _visible = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(seconds: 1),
      onEnd: () {
        if (!_visible) {
          widget.onDismissed?.call();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.03,
          vertical: size.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(size.width * 0.02),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Deslize para ver mais',
              style: TextStyle(
                fontSize: size.width * 0.035,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height * 0.005),
            AnimatedBuilder(
              animation: _controller,
              builder: (_, __) => Transform.translate(
                offset: Offset(
                  0,
                  Tween<double>(
                    begin: 0,
                    end: size.height * 0.015,
                  )
                      .animate(_controller)
                      .value,
                ),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: size.width * 0.1,
                  color: AppColors.textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
