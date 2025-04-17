// lib/screens/aluno_screen.dart

import 'package:flutter/material.dart';
import 'screen_header.dart';
import 'menu_grid.dart';
import 'bottom_navigation.dart';
import '../../styles/colors.dart';

class AlunoScreen extends StatefulWidget {
  const AlunoScreen({Key? key}) : super(key: key);

  @override
  _AlunoScreenState createState() => _AlunoScreenState();
}

class _AlunoScreenState extends State<AlunoScreen> {
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
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent ||
            _scrollController.position.maxScrollExtent == 0) {
          if (_showDownArrow) {
            setState(() {
              _showDownArrow = false;
            });
          }
        } else {
          if (!_showDownArrow) {
            setState(() {
              _showDownArrow = true;
            });
          }
        }
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
    final double horizontalPadding = size.width * 0.04;
    final double verticalPadding = size.height * 0.02;

    return Scaffold(
      backgroundColor: AppColors.solidBackgroundColor,
      extendBody: true,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.mainGradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Cabeçalho do aluno
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: HeaderWidget(size: size),
              ),
              // Grid de Menu
              Expanded(
                child: MenuGrid(
                  scrollController: _scrollController,
                  size: size,
                  verticalPadding: verticalPadding,
                  bannerVisible: _showDownArrow && !_bannerDismissed,
                  onBannerDismissed: () {
                    setState(() {
                      _bannerDismissed = true;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        size: size,
        horizontalPadding: horizontalPadding,
        verticalPadding: verticalPadding,
      ),
    );
  }
}
