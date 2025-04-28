class Horario {
  DateTime _inicio;
  DateTime _fim;
  String _local;
  String _disciplina;
  String _professor;

  Horario({
    required DateTime inicio,
    required DateTime fim,
    required String local,
    required String disciplina,
    required String professor,
  })  : _inicio = inicio,
        _fim = fim,
        _local = local,
        _disciplina = disciplina,
        _professor = professor;

  // Getters
  DateTime get inicio => _inicio;
  DateTime get fim => _fim;
  String get local => _local;
  String get disciplina => _disciplina;
  String get professor => _professor;

  // Setters
  set inicio(DateTime value) => _inicio = value;
  set fim(DateTime value) => _fim = value;
  set local(String value) => _local = value;
  set disciplina(String value) => _disciplina = value;
  set professor(String value) => _professor = value;

  @override
  String toString() {
    return 'Horário: $disciplina com $professor\n'
           'Local: $local\n'
           'Início: ${_formatTime(inicio)} - Fim: ${_formatTime(fim)}';
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}