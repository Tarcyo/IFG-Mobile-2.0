// domain/usecases/get_dias_da_semana_usecase.dart


import 'package:ifg_mobile_estudante/layers/domain/entities/models/dayOdschedule_entity.dart';

abstract class GetDiasDaSemanaUseCase {
  Future<List<DiaDaSemana?>?>? call(String matricula);
}