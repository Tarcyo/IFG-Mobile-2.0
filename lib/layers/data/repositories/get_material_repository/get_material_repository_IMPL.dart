

import 'package:ifg_mobile_estudante/layers/data/datasources/get_materiais_dataSource.dart';
import 'package:ifg_mobile_estudante/layers/domain/entities/models/material_entity.dart';
import 'package:ifg_mobile_estudante/layers/domain/repositories/get_material_repository/get_material_repository.dart';

class GetDisciplinasPorMatriculaRepositoryImpl
    implements GetDisciplinasPorMatriculaRepository {
  final GetDisciplinasPorMatriculaDatasource _getDisciplinasPorMatriculaDatasource;

  GetDisciplinasPorMatriculaRepositoryImpl(this._getDisciplinasPorMatriculaDatasource);

  @override
  Future<List<Disciplina_Material?>> call(String matricula) async {
    final disciplinasDTO = await _getDisciplinasPorMatriculaDatasource.call(matricula);

    if (disciplinasDTO == null || disciplinasDTO.isEmpty) {
      return [];
    }

    return disciplinasDTO.map((dto) => dto?.toEntity()).toList();
  }
}
