// layers/data/datasources/get_anos_boletim_datasource.dart


import 'package:ifg_mobile_estudante/layers/data/dto/ano_boletimDTO.dart';

abstract class GetAnosBoletimDatasource {
  Future<List<AnoDTO?>?> call(String matricula);
}