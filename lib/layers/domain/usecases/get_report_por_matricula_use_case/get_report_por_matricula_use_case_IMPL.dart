// domain/usecases/get_anos_boletim_usecase_impl.dart

import 'get_report_por_matricula_use_case.dart';
import '../../entities/models/year_of_report.dart';
import '../../repositories/get_boletim_por_matricula_repository/get_boletim_por_matricula._repository.dart';

class GetAnosDoBoletimUseCaseImpl implements GetAnosDoBoletimUseCase {
  final GetAnosDoBoletimRepository _repository;

  GetAnosDoBoletimUseCaseImpl(this._repository);

  @override
  Future<List<Ano?>?> call(String matricula) async {
    if (matricula.isEmpty) {
      throw ArgumentError('A matrícula não pode ser vazia.');
    }

    try {
      return await _repository.call(matricula) ?? [];
    } catch (e) {
      throw Exception('Erro ao buscar anos do boletim: $e');
    }
  }
}
