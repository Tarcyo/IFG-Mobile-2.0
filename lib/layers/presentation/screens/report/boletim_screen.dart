import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/core/utils/scroll_hint_banner.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/report/subject_card_widget.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/report/year_selector.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'screen_header.dart';

class BoletimScreen extends StatefulWidget {
  const BoletimScreen({Key? key}) : super(key: key);

  @override
  State<BoletimScreen> createState() => _BoletimScreenState();
}

class _BoletimScreenState extends State<BoletimScreen> {
    final Map<String, List<Map<String, String>>> reportData = {
    '2023': [
      {
        'subject': 'Matemática',
        'status': 'Aprovado',
        'teacher': 'Prof. Silva',
        'average': '8.5',
        'absences': '2/10',
      },
      {
        'subject': 'Física',
        'status': 'Aprovado',
        'teacher': 'Prof. Souza',
        'average': '7.8',
        'absences': '1/8',
      },
    ],
    '2022': [
      {
        'subject': 'Química',
        'status': 'Reprovado',
        'teacher': 'Prof. Almeida',
        'average': '5.4',
        'absences': '4/10',
      },
      {
        'subject': 'História',
        'status': 'Aprovado',
        'teacher': 'Prof. Costa',
        'average': '8.9',
        'absences': '0/12',
      },
      {
        'subject': 'Geografia',
        'status': 'Aprovado',
        'teacher': 'Prof. Ribeiro',
        'average': '9.2',
        'absences': '1/10',
      },
    ],
    '2021': [
      {
        'subject': 'Literatura',
        'status': 'Aprovado',
        'teacher': 'Profª. Lima',
        'average': '8.0',
        'absences': '2/8',
      },
      {
        'subject': 'Biologia',
        'status': 'Aprovado',
        'teacher': 'Prof. Martins',
        'average': '8.3',
        'absences': '3/10',
      },
    ],
  };

  late String _selectedYear;
  final ScrollController _gradesScrollController = ScrollController();
  bool _showScrollHint = false;
  bool _bannerDismissed = false;

  @override
  void initState() {
    super.initState();
    _selectedYear = reportData.keys.first;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_gradesScrollController.hasClients &&
          _gradesScrollController.position.maxScrollExtent > 0) {
        setState(() => _showScrollHint = true);
      }
    });
    _gradesScrollController.addListener(() {
      if (_gradesScrollController.hasClients) {
        final isAtBottom =
            _gradesScrollController.offset >=
            _gradesScrollController.position.maxScrollExtent;
        setState(() => _showScrollHint = !isAtBottom);
      }
    });
  }

  @override
  void dispose() {
    _gradesScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subjects = reportData[_selectedYear] ?? [];

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.solidBackgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.screenBackgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              HeaderWidget(onBack: () => Navigator.of(context).pop()),
              YearSelector(
                years: reportData.keys.toList(),
                selectedYear: _selectedYear,
                onYearSelected: (year) => setState(() => _selectedYear = year),
              ),
              SizedBox(height: 6),
              Expanded(
                child: Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: ListView.builder(
                        key: ValueKey(_selectedYear),
                        controller: _gradesScrollController,
                        itemCount: subjects.length,
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        itemBuilder: (context, index) {
                          return SubjectCard(subjectData: subjects[index]);
                        },
                      ),
                    ),
                    if (_showScrollHint && !_bannerDismissed)
                      Positioned(
                        bottom: 16,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: ScrollHintBanner(
                            onDismissed: () => setState(() => _bannerDismissed = true),
                          ),
                        ),
                      ),
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