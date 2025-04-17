import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/horário_de_aula_screen/day_tab_content.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

import 'screen_header.dart';

class HorarioDeAulaScreen extends StatefulWidget {
  const HorarioDeAulaScreen({Key? key}) : super(key: key);

  @override
  _HorarioDeAulaScreenState createState() => _HorarioDeAulaScreenState();
}

class _HorarioDeAulaScreenState extends State<HorarioDeAulaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _days = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex'];

  final Map<String, List<Map<String, String>>> scheduleData = {
    'Seg': [
      {
        'subject': 'Matemática',
        'professor': 'Prof. Silva',
        'start': '08:00',
        'end': '09:30',
        'location': 'Sala 101'
      },
      {
        'subject': 'Física',
        'professor': 'Profª. Oliveira',
        'start': '10:00',
        'end': '11:30',
        'location': 'Sala 202'
      },
    ],
    'Ter': [
      {
        'subject': 'Química',
        'professor': 'Prof. Souza',
        'start': '08:00',
        'end': '09:30',
        'location': 'Sala 103'
      },
      {
        'subject': 'Geografia',
        'professor': 'Profª. Costa',
        'start': '10:00',
        'end': '11:30',
        'location': 'Sala 204'
      },
    ],
    'Qua': [
      {
        'subject': 'História',
        'professor': 'Profª. Costa',
        'start': '09:00',
        'end': '10:30',
        'location': 'Sala 104'
      },
      {
        'subject': 'Literatura',
        'professor': 'Prof. Almeida',
        'start': '11:00',
        'end': '12:30',
        'location': 'Sala 205'
      },
    ],
    'Qui': [
      {
        'subject': 'Biologia',
        'professor': 'Prof. Lima',
        'start': '10:00',
        'end': '11:30',
        'location': 'Sala 105'
      },
      {
        'subject': 'Química',
        'professor': 'Profª. Santos',
        'start': '12:00',
        'end': '13:30',
        'location': 'Sala 206'
      },
    ],
    'Sex': [
      {
        'subject': 'Inglês',
        'professor': 'Profª. Mendes',
        'start': '08:30',
        'end': '10:00',
        'location': 'Sala 106'
      },
      {
        'subject': 'Educação Física',
        'professor': 'Prof. Oliveira',
        'start': '10:30',
        'end': '12:00',
        'location': 'Quadra'
      },
    ],
  };

  bool _bannerDismissed = false;

  @override
  void initState() {
    super.initState();
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
