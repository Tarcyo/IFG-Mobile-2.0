
import 'package:ifg_mobile_estudante/layers/domain/entities/models/material_entity.dart';

class MaterialDTO {
  final String nome;
  final String tipoDeArquivo;
  final DateTime data;
  final String link;

  MaterialDTO({
    required this.nome,
    required this.tipoDeArquivo,
    required this.data,
    required this.link,
  });

  factory MaterialDTO.fromJson(Map<String, dynamic> json) {
    try {
      return MaterialDTO(
        nome: json['nome'] as String? ?? '',
        tipoDeArquivo: json['tipoDeArquivo'] as String? ?? '',
        data: DateTime.parse(json['data'] as String? ?? DateTime.now().toIso8601String()),
        link: json['link'] as String? ?? '',
      );
    } catch (e) {
      throw Exception('Erro ao converter JSON para MaterialDTO: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'tipoDeArquivo': tipoDeArquivo,
      'data': data.toIso8601String(),
      'link': link,
    };
  }

  Material toEntity() {
    return Material(
      nome: nome,
      tipoDeArquivo: tipoDeArquivo,
      data: data,
      link: link,
    );
  }

  static List<MaterialDTO> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MaterialDTO.fromJson(json)).toList();
  }
}