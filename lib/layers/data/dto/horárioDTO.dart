import 'package:ifg_mobile_estudante/layers/domain/entities/models/schedule_entity.dart';

class HorarioDTO {
  final String inicio;
  final String fim;
  final String local;
  final String disciplina;
  final String professor;

  HorarioDTO({
    required this.inicio,
    required this.fim,
    required this.local,
    required this.disciplina,
    required this.professor,
  });

  factory HorarioDTO.fromJson(Map<String, dynamic> json) {
    try {
      return HorarioDTO(
        inicio: json['inicio'] as String? ?? '',
        fim: json['fim'] as String? ?? '',
        local: json['local'] as String? ?? '',
        disciplina: json['disciplina'] as String? ?? '',
        professor: json['professor'] as String? ?? '',
      );
    } catch (e) {
      throw Exception('Erro ao converter JSON para HorarioDTO: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'inicio': inicio,
      'fim': fim,
      'local': local,
      'disciplina': disciplina,
      'professor': professor,
    };
  }

  Horario toEntity() {
    return Horario(
      inicio: DateTime.parse(inicio),
      fim: DateTime.parse(fim),
      local: local,
      disciplina: disciplina,
      professor: professor,
    );
  }

  static List<HorarioDTO> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => HorarioDTO.fromJson(json)).toList();
  }
}
