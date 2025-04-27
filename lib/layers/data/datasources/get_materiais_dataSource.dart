
import 'package:ifg_mobile_estudante/layers/data/dto/materialDiciplineDTO.dart';

abstract class GetDisciplinasPorMatriculaDatasource {
  Future<List<DisciplinaMaterialDTO?>?> call(String matricula);
}
