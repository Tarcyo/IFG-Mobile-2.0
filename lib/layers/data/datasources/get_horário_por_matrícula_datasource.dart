// layers/data/datasources/get_dias_da_semana_datasource.dart


import 'package:ifg_mobile_estudante/layers/data/dto/diaDaSemanaDTO.dart';

abstract class GetDiasDaSemanaDatasource {
  Future<List<DiaDaSemanaDTO?>?> call(String matricula);
}