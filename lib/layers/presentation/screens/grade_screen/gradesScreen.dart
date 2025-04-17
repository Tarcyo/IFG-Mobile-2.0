import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/notas_list_controller_provider.dart';
import 'package:ifg_mobile_estudante/core/utils/scroll_hint_banner.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/grade_screen/grade_discipline_card.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/grade_screen/screen_header.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'package:provider/provider.dart';

class GradesScreen extends StatefulWidget {
  const GradesScreen({Key? key}) : super(key: key);

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  Map<String, List<Map<String, String>>> gradesData = {};
  late String _selectedDiscipline;
  final ScrollController _listScrollController = ScrollController();
  bool _showScrollHint = false;
  bool _gradesBannerDismissed = false;

  @override
  void initState() {
    final notasProvider = Provider.of<NotasControlerProvider>(
      context,
      listen: false,
    );

    final notasDoAluno = notasProvider.controller.notas;
    print("as notas do aluno são:" + notasDoAluno.toString());

    for (final i in notasDoAluno!) {
      gradesData.addAll({
        i!.nomeDisciplina!.substring(i.nomeDisciplina!.indexOf(' - ') + 2): [
          {
            'activity': "Atividade 1",
            'grade': i.nota1.toString(),
            'description': 'Atividade aplicada pelo professor',
            'date': '0/0/0',
          },
          {
            'activity': "Atividade 2",
            'grade': i.nota2.toString(),
            'description': 'Atividade aplicada pelo professor',
            'date': '0/0/0',
          },
          {
            'activity': "Atividade 3",
            'grade': i.nota3.toString(),
            'description': 'Atividade aplicada pelo professor',
            'date': '0/0/0',
          },
          {
            'activity': "Atividade 4",
            'grade': i.nota4.toString(),
            'description': 'Atividade aplicada pelo professor',
            'date': '0/0/0',
          },
          {
            'activity': "Nota Final",
            'grade': i.notaFinal.toString(),
            'description': 'Atividade aplicada pelo professor',
            'date': '0/0/0',
          },
        ],
      });
    }
    super.initState();
    _selectedDiscipline = gradesData.keys.first;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_listScrollController.hasClients &&
          _listScrollController.position.maxScrollExtent > 0) {
        setState(() {
          _showScrollHint = true;
        });
      }
    });

    _listScrollController.addListener(() {
      if (_listScrollController.hasClients) {
        final isAtBottom =
            _listScrollController.offset >=
                _listScrollController.position.maxScrollExtent ||
            _listScrollController.position.maxScrollExtent == 0;
        setState(() {
          _showScrollHint = !isAtBottom;
        });
      }
    });
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double verticalPadding = size.height * 0.025;
    final grades = gradesData[_selectedDiscipline] ?? [];

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
              // Cabeçalho
              ScreenHeader(
                title: 'Notas por Disciplina',
                size: size,
                verticalPadding: verticalPadding,
                disciplines: gradesData.keys.toList(),
                selectedDiscipline: _selectedDiscipline,
                onDisciplineSelected: (discipline) {
                  setState(() {
                    _selectedDiscipline = discipline;
                  });
                },
              ),
              const SizedBox(height: 6),
              // Listagem das notas
              Expanded(
                child: Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (child, animation) =>
                              FadeTransition(opacity: animation, child: child),
                      child: ListView.builder(
                        key: ValueKey(_selectedDiscipline),
                        controller: _listScrollController,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: grades.length,
                        itemBuilder: (context, index) {
                          return GradeCard(gradeData: grades[index]);
                        },
                      ),
                    ),
                    if (_showScrollHint && !_gradesBannerDismissed)
                      Positioned(
                        bottom: 16,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: ScrollHintBanner(
                            onDismissed: () {
                              setState(() {
                                _gradesBannerDismissed = true;
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
