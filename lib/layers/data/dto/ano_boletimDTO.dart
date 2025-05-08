import 'package:ifg_mobile_estudante/layers/data/dto/discipline_boletimDTO.dart';
import 'package:ifg_mobile_estudante/layers/domain/entities/models/year_of_report.dart';

class AnoDTO {
  final int numeroAno;
  final List<DisciplinaBoletimDTO> disciplinas;

  AnoDTO({
    required this.numeroAno,
    required this.disciplinas,
  });

  factory AnoDTO.fromJson(Map<String, dynamic> json) {
    try {
      return AnoDTO(
        numeroAno: json['numeroAno'] as int? ?? 0,
        disciplinas: (json['disciplinas'] as List<dynamic>?)
                ?.map((item) => DisciplinaBoletimDTO.fromJson(item))
                .toList() ??
            [],
      );
    } catch (e) {
      throw Exception('Erro ao converter JSON para AnoDTO: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'numeroAno': numeroAno,
      'disciplinas': disciplinas.map((disciplina) => disciplina.toJson()).toList(),
    };
  }

  Ano toEntity() {
    return Ano(
      numeroAno: numeroAno,
      disciplinas: disciplinas.map((disciplinaDTO) => disciplinaDTO.toEntity()).toList(),
    );
  }

  static List<AnoDTO> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AnoDTO.fromJson(json)).toList();
  }
}