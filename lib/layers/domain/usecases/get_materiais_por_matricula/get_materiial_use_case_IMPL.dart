// domain/usecases/get_disciplinas_por_matricula_usecase/get_disciplinas_por_matricula_usecase_impl.dart


import 'package:ifg_mobile_estudante/layers/domain/entities/models/material_entity.dart';
import 'package:ifg_mobile_estudante/layers/domain/repositories/get_material_repository/get_material_repository.dart';
import 'package:ifg_mobile_estudante/layers/domain/usecases/get_materiais_por_matricula/get_materials_usecase.dart';

class GetDisciplinasPorMatriculaUseCaseImpl implements GetDisciplinasPorMatriculaUseCase {
  final GetDisciplinasPorMatriculaRepository _repository;

  GetDisciplinasPorMatriculaUseCaseImpl(this._repository);

  @override
  Future<List<Disciplina_Material?>?> call(String matricula) async {
    if (matricula.isEmpty) {
      throw ArgumentError('A matrícula não pode ser vazia.');
    }

    try {
      return await _repository.call(matricula) ?? [];
    } catch (e) {
      throw Exception('Erro ao buscar disciplinas do aluno: $e');
    }
  }
}
