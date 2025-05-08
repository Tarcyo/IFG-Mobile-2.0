// domain/usecases/get_disciplinas_por_matricula_usecase.dart

import 'package:ifg_mobile_estudante/layers/domain/entities/models/material_entity.dart';


abstract class GetDisciplinasPorMatriculaUseCase {
  Future<List<Disciplina_Material?>?>? call(String matricula);
}