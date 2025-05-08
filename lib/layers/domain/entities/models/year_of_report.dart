import 'discipline_of_report.dart';
class Ano {
  int _numeroAno;
  List<DisciplinaBoletim> _disciplinas;

  Ano({
    required int numeroAno,
    required List<DisciplinaBoletim> disciplinas,
  })  : _numeroAno = numeroAno,
        _disciplinas = disciplinas;

  // Getters
  int get numeroAno => _numeroAno;
  List<DisciplinaBoletim> get disciplinas => _disciplinas;

  // Setters
  set numeroAno(int value) {
    _numeroAno = value;
  }

  set disciplinas(List<DisciplinaBoletim> value) {
    _disciplinas = value;
  }

  @override
  String toString() {
    return 'Ano(numeroAno: $_numeroAno, disciplinas: $_disciplinas)';
  }
}
