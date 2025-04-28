import 'package:ifg_mobile_estudante/layers/domain/entities/models/schedule_entity.dart';

class DiaDaSemana {
  String _abreviatura;
  List<Horario> _horarios;

  DiaDaSemana({
    required String abreviatura,
    required List<Horario> horarios,
  })  : _abreviatura = abreviatura,
        _horarios = horarios;

  // Getters
  String get abreviatura => _abreviatura;
  List<Horario> get horarios => _horarios;

  // Setters
  set abreviatura(String value) => _abreviatura = value;
  set horarios(List<Horario> value) => _horarios = value;

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('Dia: ${abreviatura.toUpperCase()}');
    for (var horario in horarios) {
      buffer.writeln(horario.toString());
      buffer.writeln(''); // Linha extra para separar os horários
    }
    return buffer.toString();
  }
}