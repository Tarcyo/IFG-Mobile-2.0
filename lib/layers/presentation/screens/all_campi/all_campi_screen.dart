import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/core/utils/scroll_hint_banner.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/all_campi/all_campi_controller.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/all_campi/campus_card.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/campus_screen/campus_screen.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class AllCampiScreen extends StatelessWidget {
  const AllCampiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AllCampiController(),
      child: const _AllCampiView(),
    );
  }
}

class _AllCampiView extends StatefulWidget {
  const _AllCampiView();

  @override
  State<_AllCampiView> createState() => __AllCampiViewState();
}

class __AllCampiViewState extends State<_AllCampiView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AllCampiController>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AllCampiController>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.solidBackgroundColor,
      body: Container(
        decoration: _buildBackgroundDecoration(),
        child: SafeArea(
          child: Stack(
            children: [
              _buildContent(controller, size),
              if (controller.showDownArrow && !controller.bannerDismissed)
                _buildScrollBanner(context, controller),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: AppColors.mainGradientColors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      boxShadow: const [
        BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 8),
      ],
    );
  }

  Widget _buildContent(AllCampiController controller, Size size) {
    return SingleChildScrollView(
      controller: controller.scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.02,
      ),
      child: Column(children: [_buildHeader(size), _buildCampusGrid(size)]),
    );
  }

  Widget _buildHeader(Size size) {
    return Column(
      children: [
        SizedBox(height: size.height * 0.02),
        CircleAvatar(
          radius: size.height * 0.08,
          backgroundColor: AppColors.textColor,
          child: Icon(
            Icons.travel_explore_rounded,
            size: size.height * 0.06,
            color: AppColors.solidBackgroundColor,
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Text(
          'Campi',
          style: TextStyle(
            fontSize: size.width * 0.06,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
            shadows: const [
              Shadow(
                color: Colors.black54,
                blurRadius: 4,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCampusGrid(Size size) {
    const campusList = [
      'Águas Lindas',
      'Anápolis',
      'Aparecida',
      'Formosa',
      'Goiânia',
      'Goiânia Oeste',
      'Goiás',
      'Inhumas',
      'Itumbiara',
      'Jataí',
      'Luziânia',
      'Senador Canedo',
      'Uruaçu',
      'Valparaíso',
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03,
            vertical: size.height * 0.02,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: size.width * 0.03,
            mainAxisSpacing: size.height * 0.02,
            childAspectRatio: _calculateAspectRatio(size),
          ),
          itemCount: campusList.length,
          itemBuilder: (context, index) => CampusCard(
            title: campusList[index],
            imagePath: "assets/images/${campusList[index]}.jpg",
            onTap: () => _navigateToCampus(context, campusList[index]),
          ),
        );
      },
    );
  }

  double _calculateAspectRatio(Size size) {
    if (size.width > 1000) return 1.2;
    if (size.width > 600) return 1.0;
    return 0.8;
  }

  void _navigateToCampus(BuildContext context, String campus) async {
    final jsonString = await rootBundle.loadString('assets/data/campi.json');
    final dados = jsonDecode(jsonString);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CampusScreen(name: campus, dados: dados),
      ),
    );
  }

  Widget _buildScrollBanner(
    BuildContext context,
    AllCampiController controller,
  ) {
    final size = MediaQuery.of(context).size;

    return Positioned(
      bottom: size.height * 0.03,
      left: 0,
      right: 0,
      child: Center(
        child: ScrollHintBanner(onDismissed: controller.dismissBanner),
      ),
    );
  }
}
