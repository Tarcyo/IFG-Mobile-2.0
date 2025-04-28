// domain/usecases/get_anos_boletim_usecase.dart

import '../../entities/models/year_of_report.dart'; // Imaginando que o Ano esteja salvo aí

abstract class GetAnosDoBoletimUseCase {
  Future<List<Ano?>?> call(String matricula);
}