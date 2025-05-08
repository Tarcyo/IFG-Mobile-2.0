// interface permanece
import 'package:ifg_mobile_estudante/layers/domain/entities/models/dayOdschedule_entity.dart';
import 'package:ifg_mobile_estudante/layers/domain/repositories/get_hor%C3%A1rio_por_matr%C3%ADcula_repository/get_hor%C3%A1rio_por_matricula_repository.dart';
import 'package:ifg_mobile_estudante/layers/domain/usecases/get_hor%C3%A1rio_por_matr%C3%ADcula_usecase/get_hor%C3%A1rio_por_matr%C3%ADcula.dart';

abstract class GetDiasDaSemanaUseCaseIMPL {
  Future<List<DiaDaSemana?>?>? call(String matricula);
}

// implementação
class GetDiasDaSemanaUseCaseImpl implements GetDiasDaSemanaUseCase {
  final GetDiasDaSemanaRepository _repository;
  GetDiasDaSemanaUseCaseImpl(this._repository);

  @override
  Future<List<DiaDaSemana?>?>? call(String matricula) async {
    if (matricula.isEmpty) {
      throw ArgumentError('A matrícula não pode ser vazia.');
    }
    try {
      return await _repository(matricula);
    } catch (e) {
      throw Exception('Erro ao buscar dias da semana do aluno: $e');
    }
  }
}