// Entidade para Materiais por Disciplina
import 'package:ifg_mobile_estudante/layers/domain/entities/models/material_entity.dart';


class MateriaisDisciplinaEntity {
  final String? _nomeDisciplina;
  final List<Material> _materiais;

  // Construtor
  MateriaisDisciplinaEntity(
    this._nomeDisciplina,
    this._materiais,
  );

  // Getters
  String? get nomeDisciplina => _nomeDisciplina;
  List<Material> get materiais => _materiais;

  // Método toString
  @override
  String toString() {
    return 'MateriaisDisciplinaEntity{\n'
        '  nomeDisciplina: $_nomeDisciplina,\n'
        '  materiais: $_materiais\n'
        '}';
  }
}
