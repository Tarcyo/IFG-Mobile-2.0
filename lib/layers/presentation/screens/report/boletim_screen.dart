import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/core/utils/scroll_hint_banner.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/boletim_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/report/subject_card_widget.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/report/year_selector.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'package:provider/provider.dart';
import 'screen_header.dart';

class BoletimScreen extends StatefulWidget {
  const BoletimScreen({Key? key}) : super(key: key);

  @override
  State<BoletimScreen> createState() => _BoletimScreenState();
}

class _BoletimScreenState extends State<BoletimScreen> {
  final Map<String, List<Map<String, String>>> reportData = {};

  late String _selectedYear;
  final ScrollController _gradesScrollController = ScrollController();
  bool _showScrollHint = false;
  bool _bannerDismissed = false;

  @override
  void initState() {
    super.initState();
    for (final ano
        in Provider.of<AnosBoletimControllerProvider>(
          context,
          listen: false,
        ).controller.anosBoletim!) {
      reportData.addAll({ano!.numeroAno.toString(): [
         
        ],
      });
      for (final i in ano.disciplinas) {
        reportData[ano.numeroAno.toString()]!.add({
          'subject': i.nome,
          'status': i.situacao,
          'teacher': i.professor,
          'average': i.media.toString(),
          'absences': i.faltas.toString() + "/" + i.maximoFaltas.toString(),
        });
      }
    }
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
              HeaderWidget(),
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
                      transitionBuilder:
                          (child, animation) =>
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
                            onDismissed:
                                () => setState(() => _bannerDismissed = true),
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
