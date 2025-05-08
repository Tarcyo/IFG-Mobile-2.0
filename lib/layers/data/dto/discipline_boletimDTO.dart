import 'package:ifg_mobile_estudante/layers/domain/entities/models/discipline_of_report.dart';

class DisciplinaBoletimDTO {
  final String nome;
  final String professor;
  final String situacao;
  final double media;
  final int faltas;
  final int maximoFaltas;

  DisciplinaBoletimDTO({
    required this.nome,
    required this.professor,
    required this.situacao,
    required this.media,
    required this.faltas,
    required this.maximoFaltas,
  });

  factory DisciplinaBoletimDTO.fromJson(Map<String, dynamic> json) {
    try {
      return DisciplinaBoletimDTO(
        nome: json['nome'] as String? ?? '',
        professor: json['professor'] as String? ?? '',
        situacao: json['situacao'] as String? ?? '',
        media: (json['media'] as num?)?.toDouble() ?? 0.0,
        faltas: json['faltas'] as int? ?? 0,
        maximoFaltas: json['maximoFaltas'] as int? ?? 0,
      );
    } catch (e) {
      throw Exception('Erro ao converter JSON para DisciplinaBoletimDTO: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'professor': professor,
      'situacao': situacao,
      'media': media,
      'faltas': faltas,
      'maximoFaltas': maximoFaltas,
    };
  }

  DisciplinaBoletim toEntity() {
    return DisciplinaBoletim(
      nome: nome,
      professor: professor,
      situacao: situacao,
      media: media,
      faltas: faltas,
      maximoFaltas: maximoFaltas,
    );
  }

  static List<DisciplinaBoletimDTO> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DisciplinaBoletimDTO.fromJson(json)).toList();
  }
}