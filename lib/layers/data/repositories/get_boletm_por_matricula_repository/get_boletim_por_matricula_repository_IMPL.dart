

import 'package:ifg_mobile_estudante/layers/data/datasources/get_boletim_por_matricula_datasource.dart';
import 'package:ifg_mobile_estudante/layers/domain/entities/models/year_of_report.dart';
import 'package:ifg_mobile_estudante/layers/domain/repositories/get_boletim_por_matricula_repository/get_boletim_por_matricula._repository.dart';

class GetAnosDoBoletimRepositoryImpl implements GetAnosDoBoletimRepository {
  final GetAnosBoletimDatasource _getAnosBoletimDatasource;

  GetAnosDoBoletimRepositoryImpl(this._getAnosBoletimDatasource);

  @override
  Future<List<Ano>> call(String matricula) async {
    final anosDTO = await _getAnosBoletimDatasource.call(matricula);

    if (anosDTO == null || anosDTO.isEmpty) {
      return [];
    }

    return anosDTO.map((dto) => dto?.toEntity()).whereType<Ano>().toList();
  }
}