
import 'package:ifg_mobile_estudante/layers/domain/entities/models/material_entity.dart';
import 'package:ifg_mobile_estudante/layers/domain/usecases/get_materiais_por_matricula/get_materials_usecase.dart';

class DisciplinaMaterialController {
  final GetDisciplinasPorMatriculaUseCase _getDisciplinasPorMatriculaUseCase;

  DisciplinaMaterialController({required GetDisciplinasPorMatriculaUseCase getDisciplinasPorMatriculaUseCase})
      : _getDisciplinasPorMatriculaUseCase = getDisciplinasPorMatriculaUseCase;

  late List<Disciplina_Material?>? disciplinas;

  Future<void> getDisciplinasPorMatricula(String matricula) async {
    disciplinas = await _getDisciplinasPorMatriculaUseCase(matricula);
    print("os materiais são:"+disciplinas.toString());
  }
}