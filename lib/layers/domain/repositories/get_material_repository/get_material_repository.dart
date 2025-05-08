// domain/repositories/get_disciplinas_por_matricula_repository.dart

import 'package:ifg_mobile_estudante/layers/domain/entities/models/material_entity.dart';


abstract class GetDisciplinasPorMatriculaRepository {
  Future<List<Disciplina_Material?>?> call(String matricula);
}