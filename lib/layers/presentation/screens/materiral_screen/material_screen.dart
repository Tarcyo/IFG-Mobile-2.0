import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/core/utils/scroll_hint_banner.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'screen_header.dart';
import 'discipline_selector.dart';
import 'material_card.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({Key? key}) : super(key: key);

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  // Dados simulados: cada disciplina possui uma lista de materiais
  final Map<String, List<Map<String, String>>> materialsData = {
    'Matemática': [
      {
        'name': 'Apostila Álgebra Linear',
        'fileType': 'PDF',
        'date': '01/04/2025',
      },
      {
        'name': 'Exercícios de Geometria',
        'fileType': 'DOCX',
        'date': '05/04/2025',
      },
    ],
    'História': [
      {
        'name': 'Linha do Tempo das Guerras Mundiais',
        'fileType': 'PDF',
        'date': '03/04/2025',
      },
    ],
    'Biologia': [
      {
        'name': 'Material Genética e Evolução',
        'fileType': 'PPT',
        'date': '07/04/2025',
      },
    ],
    'Química': [
      {
        'name': 'Tabela Periódica Interativa',
        'fileType': 'HTML',
        'date': '02/04/2025',
      },
    ],
    'Literatura': [
      {
        'name': 'Análise de Obras Clássicas',
        'fileType': 'PDF',
        'date': '06/04/2025',
      },
    ],
  };

  late String _selectedDiscipline;
  final ScrollController _scrollController = ScrollController();
  bool _showScrollHint = false;
  bool _bannerDismissed = false;

  @override
  void initState() {
    super.initState();
    _selectedDiscipline = materialsData.keys.first;

    // Verifica se há conteúdo rolável para mostrar o banner
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
        final isAtBottom = _scrollController.offset >=
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

  // Constrói a lista de ChoiceChips para selecionar a disciplina
  Widget _buildDisciplineSelector() {
    return DisciplineSelector(
      disciplines: materialsData.keys.toList(),
      selectedDiscipline: _selectedDiscipline,
      onDisciplineSelected: (discipline) {
        setState(() {
          _selectedDiscipline = discipline;
          // O banner não é reiniciado se já tiver sido dismissado
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
              // Cabeçalho com botão de voltar e título
              ScreenHeader(
                title: 'Materiais Escolares',
                onBack: () => Navigator.of(context).pop(),
                horizontalPadding: size.width * 0.04,
                verticalPadding: verticalPadding,
                fontSize: size.width * 0.055,
              ),
              // Seletor de disciplinas
              _buildDisciplineSelector(),
              const SizedBox(height: 6),
              // Lista dos materiais
              Expanded(
                child: Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
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
