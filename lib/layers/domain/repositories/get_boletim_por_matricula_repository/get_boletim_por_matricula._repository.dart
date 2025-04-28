// domain/repositories/get_anos_boletim_repository/get_anos_boletim_repository.dart

import '../../entities/models/year_of_report.dart';

abstract class GetAnosDoBoletimRepository {
  Future<List<Ano?>?> call(String matricula);
}