

import 'package:ifg_mobile_estudante/layers/domain/entities/models/year_of_report.dart';
import 'package:ifg_mobile_estudante/layers/domain/usecases/get_report_por_matricula_use_case/get_report_por_matricula_use_case.dart';

class AnosBoletimController {
  final GetAnosDoBoletimUseCase _getAnosBoletimUseCase;

  AnosBoletimController({required GetAnosDoBoletimUseCase getAnosBoletimUseCase})
      : _getAnosBoletimUseCase = getAnosBoletimUseCase;

  late List<Ano?>? anosBoletim;

  Future<void> getAnosBoletim(String matricula) async {
    anosBoletim = await _getAnosBoletimUseCase(matricula);
    print("Os anos do boletim são: ${anosBoletim.toString()}");
  }
}
