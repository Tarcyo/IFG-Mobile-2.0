import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/dia_da_semana_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/horário_de_aula_screen/day_tab_content.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'package:provider/provider.dart';

import 'screen_header.dart';

class HorarioDeAulaScreen extends StatefulWidget {
  const HorarioDeAulaScreen({Key? key}) : super(key: key);

  @override
  _HorarioDeAulaScreenState createState() => _HorarioDeAulaScreenState();
}

class _HorarioDeAulaScreenState extends State<HorarioDeAulaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _days = [];

  final Map<String, List<Map<String, String>>> scheduleData = {};

  bool _bannerDismissed = false;

  @override
  void initState() {
    super.initState();
    for (final dia
        in Provider.of<DiasDaSemanaControllerProvider>(
          context,
          listen: false,
        ).controller.diasDaSemana!) {
      _days.add(dia!.abreviatura);
      scheduleData.addAll({dia.abreviatura: [
    
    ],});
      String twoDigits(int n) => n.toString().padLeft(2, '0');

      for (final horario in dia.horarios) {
        scheduleData[dia.abreviatura]!.add({
          'subject': horario.disciplina,
          'professor': horario.professor,
          'start':
              '${twoDigits(horario.inicio.hour)}:${twoDigits(horario.inicio.minute)}',
          'end':
              '${twoDigits(horario.fim.hour)}:${twoDigits(horario.fim.minute)}',
          'location': horario.local,
        });
      }
    }
    _tabController = TabController(length: _days.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildDayTab(String day) {
    final lessons = scheduleData[day] ?? [];
    return DayTabContent(
      lessons: lessons,
      bannerDismissed: _bannerDismissed,
      onBannerDismissed: () {
        setState(() {
          _bannerDismissed = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double verticalPadding = size.height * 0.025;

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.solidBackgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.screenBackgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              ScreenHeader(
                title: 'Horário de Aula',
                size: size,
                verticalPadding: verticalPadding,
              ),
              Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: AppColors.textColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelColor: AppColors.cardColor,
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: AppColors.textColor,
                    tabs: _days.map((day) => Tab(text: day)).toList(),
                    isScrollable: false,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _days.map((day) => _buildDayTab(day)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
