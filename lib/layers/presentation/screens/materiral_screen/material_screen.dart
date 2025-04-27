import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/core/utils/scroll_hint_banner.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/materiais_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'package:provider/provider.dart';
import 'screen_header.dart';
import 'discipline_selector.dart';
import 'material_card.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({Key? key}) : super(key: key);

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  final Map<String, List<Map<String, String>>> materialsData = {
   
  };

  late String _selectedDiscipline;
  final ScrollController _scrollController = ScrollController();
  bool _showScrollHint = false;
  bool _bannerDismissed = false;

  @override
  void initState() {
    super.initState();

    for (final disciplina
        in Provider.of<DisciplinaMaterialControllerProvider>(
          context,
          listen: false,
        ).controller.disciplinas!) {
      print("Disciplina:" + disciplina.toString());
      materialsData.addAll({disciplina!.nome: [
        
        ],
      });
      for (final materiais in disciplina.materiais){
        materialsData[disciplina.nome]!.add( {
        'name': materiais.nome,
        'fileType': materiais.tipoDeArquivo,
        'date': materiais.data.year.toString()+"/"+materiais.data.month.toString()+"/"+materiais.data.day.toString(),
      });
      }
    }

    _selectedDiscipline = materialsData.keys.first;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients &&
          _scrollController.position.maxScrollExtent > 0) {
        setState(() {
          _showScrollHint = true;
        });
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        final isAtBottom =
            _scrollController.offset >=
            _scrollController.position.maxScrollExtent;
        setState(() {
          _showScrollHint = !isAtBottom;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildDisciplineSelector() {
    return DisciplineSelector(
      disciplines: materialsData.keys.toList(),
      selectedDiscipline: _selectedDiscipline,
      onDisciplineSelected: (discipline) {
        setState(() {
          _selectedDiscipline = discipline;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double verticalPadding = size.height * 0.025;
    final materials = materialsData[_selectedDiscipline] ?? [];

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
              ScreenHeader(
                title: 'Materiais Escolares',
                onBack: () => Navigator.of(context).pop(),
                verticalPadding: verticalPadding,
              ),
              _buildDisciplineSelector(),
              const SizedBox(height: 6),
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
                        controller: _scrollController,
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        itemCount: materials.length,
                        itemBuilder: (context, index) {
                          return MaterialCard(material: materials[index]);
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
