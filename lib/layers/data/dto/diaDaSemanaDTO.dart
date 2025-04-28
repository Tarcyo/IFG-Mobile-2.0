

import 'package:ifg_mobile_estudante/layers/data/dto/hor%C3%A1rioDTO.dart';
import 'package:ifg_mobile_estudante/layers/domain/entities/models/dayOdschedule_entity.dart';

class DiaDaSemanaDTO {
  final String abreviatura;
  final List<HorarioDTO> horarios;

  DiaDaSemanaDTO({
    required this.abreviatura,
    required this.horarios,
  });

  factory DiaDaSemanaDTO.fromJson(Map<String, dynamic> json) {
    try {
      return DiaDaSemanaDTO(
        abreviatura: json['abreviatura'] as String? ?? '',
        horarios: (json['horarios'] as List<dynamic>?)
                ?.map((item) => HorarioDTO.fromJson(item))
                .toList() ??
            [],
      );
    } catch (e) {
      throw Exception('Erro ao converter JSON para DiaDaSemanaDTO: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'abreviatura': abreviatura,
      'horarios': horarios.map((horario) => horario.toJson()).toList(),
    };
  }

  DiaDaSemana toEntity() {
    return DiaDaSemana(
      abreviatura: abreviatura,
      horarios: horarios.map((horarioDTO) => horarioDTO.toEntity()).toList(),
    );
  }

  static List<DiaDaSemanaDTO> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DiaDaSemanaDTO.fromJson(json)).toList();
  }
}