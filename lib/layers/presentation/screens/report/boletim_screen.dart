import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/core/utils/scroll_hint_banner.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/report/subject_card_widget.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/report/year_selector.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class BoletimScreen extends StatefulWidget {
  const BoletimScreen({Key? key}) : super(key: key);

  @override
  State<BoletimScreen> createState() => _BoletimScreenState();
}

class _BoletimScreenState extends State<BoletimScreen> {
  // Dados simulados: cada ano contém uma lista de matérias com seus respectivos dados.
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

    // Detecta se o conteúdo é rolável para exibir o banner de indicação de scroll.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_gradesScrollController.hasClients &&
          _gradesScrollController.position.maxScrollExtent > 0) {
        setState(() {
          _showScrollHint = true;
        });
      }
    });
    _gradesScrollController.addListener(() {
      if (_gradesScrollController.hasClients) {
        final isAtBottom =
            _gradesScrollController.offset >=
            _gradesScrollController.position.maxScrollExtent;
        setState(() {
          _showScrollHint = !isAtBottom;
        });
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
    final size = MediaQuery.of(context).size;
    final double verticalPadding = size.height * 0.025;
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
              // Cabeçalho com botão de voltar e título centralizado.
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: verticalPadding,
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.textColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowColor,
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.textColor,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Expanded(
                      child: Text(
                        'Boletim Escolar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: size.width * 0.055,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 3,
                              color: AppColors.shadowColor,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.13),
                  ],
                ),
              ),
              // Seletor de ano
              YearSelector(
                years: reportData.keys.toList(),
                selectedYear: _selectedYear,
                onYearSelected: (year) {
                  setState(() {
                    _selectedYear = year;
                  });
                },
              ),
              const SizedBox(height: 6),
              // Área de conteúdo rolável com indicação de scroll.
              Expanded(
                child: Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (child, animation) =>
                              FadeTransition(opacity: animation, child: child),
                      child: ListView.builder(
                        key: ValueKey(_selectedYear),
                        controller: _gradesScrollController,
                        itemCount: subjects.length,
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
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
            ],
          ),
        ),
      ),
    );
  }
}
