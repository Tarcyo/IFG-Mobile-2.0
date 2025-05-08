
import 'package:ifg_mobile_estudante/layers/domain/entities/models/dayOdschedule_entity.dart';
import 'package:ifg_mobile_estudante/layers/domain/usecases/get_hor%C3%A1rio_por_matr%C3%ADcula_usecase/get_hor%C3%A1rio_por_matr%C3%ADcula.dart';

class DiasDaSemanaController {
  final GetDiasDaSemanaUseCase _getDiasDaSemanaUseCase;

  DiasDaSemanaController({required GetDiasDaSemanaUseCase getDiasDaSemanaUseCase})
      : _getDiasDaSemanaUseCase = getDiasDaSemanaUseCase;

  late List<DiaDaSemana?>? diasDaSemana;

  Future<void> getDiasDaSemana(String matricula) async {
    diasDaSemana = await _getDiasDaSemanaUseCase(matricula);
  }
}
