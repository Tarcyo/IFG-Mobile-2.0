import 'package:ifg_mobile_estudante/layers/domain/entities/models/dayOdschedule_entity.dart';

abstract class GetDiasDaSemanaRepository {
  Future<List<DiaDaSemana?>?> call(String matricula);
}
