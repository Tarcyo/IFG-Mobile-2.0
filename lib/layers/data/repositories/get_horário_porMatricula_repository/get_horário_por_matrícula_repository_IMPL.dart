

import 'package:ifg_mobile_estudante/layers/data/datasources/get_hor%C3%A1rio_por_matr%C3%ADcula_datasource.dart';
import 'package:ifg_mobile_estudante/layers/domain/entities/models/dayOdschedule_entity.dart';
import 'package:ifg_mobile_estudante/layers/domain/repositories/get_hor%C3%A1rio_por_matr%C3%ADcula_repository/get_hor%C3%A1rio_por_matricula_repository.dart';

class GetDiasDaSemanaRepositoryImpl implements GetDiasDaSemanaRepository {
  final GetDiasDaSemanaDatasource _getDiasDaSemanaDatasource;

  GetDiasDaSemanaRepositoryImpl(this._getDiasDaSemanaDatasource);

  @override
  Future<List<DiaDaSemana?>?> call(String matricula) async {
    final diasDTO = await _getDiasDaSemanaDatasource.call(matricula);

    if (diasDTO == null || diasDTO.isEmpty) {
      return [];
    }

    return diasDTO.map((dto) => dto?.toEntity()).toList();
  }
}