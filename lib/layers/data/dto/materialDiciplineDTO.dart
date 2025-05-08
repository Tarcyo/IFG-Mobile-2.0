import 'package:ifg_mobile_estudante/layers/data/dto/materialDTO.dart';
import 'package:ifg_mobile_estudante/layers/domain/entities/models/material_entity.dart';


class DisciplinaMaterialDTO {
  final String matricula;
  final String nome;
  final List<MaterialDTO> materiais;

  DisciplinaMaterialDTO({
    required this.matricula,
    required this.nome,
    required this.materiais,
  });

  factory DisciplinaMaterialDTO.fromJson(Map<String, dynamic> json) {
    try {
      return DisciplinaMaterialDTO(
        matricula: json['matricula'] as String? ?? '',
        nome: json['nome'] as String? ?? '',
        materiais: (json['materiais'] as List<dynamic>?)
                ?.map((item) => MaterialDTO.fromJson(item))
                .toList() ??
            [],
      );
    } catch (e) {
      throw Exception('Erro ao converter JSON para DisciplinaMaterialDTO: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'matricula': matricula,
      'nome': nome,
      'materiais': materiais.map((material) => material.toJson()).toList(),
    };
  }

  Disciplina_Material toEntity() {
    return Disciplina_Material(
      nome: nome,
      materiais: materiais.map((materialDTO) => materialDTO.toEntity()).toList(),
    );
  }

  static List<DisciplinaMaterialDTO> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DisciplinaMaterialDTO.fromJson(json)).toList();
  }
}