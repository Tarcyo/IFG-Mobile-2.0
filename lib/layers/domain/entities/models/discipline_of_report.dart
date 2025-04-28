class DisciplinaBoletim {
  String _nome;
  String _professor;
  String _situacao;
  double _media;
  int _faltas;
  int _maximoFaltas;

  DisciplinaBoletim({
    required String nome,
    required String professor,
    required String situacao,
    required double media,
    required int faltas,
    required int maximoFaltas,
  })  : _nome = nome,
        _professor = professor,
        _situacao = situacao,
        _media = media,
        _faltas = faltas,
        _maximoFaltas = maximoFaltas;

  // Getters
  String get nome => _nome;
  String get professor => _professor;
  String get situacao => _situacao;
  double get media => _media;
  int get faltas => _faltas;
  int get maximoFaltas => _maximoFaltas;

  // Setters
  set nome(String value) {
    _nome = value;
  }

  set professor(String value) {
    _professor = value;
  }

  set situacao(String value) {
    _situacao = value;
  }

  set media(double value) {
    _media = value;
  }

  set faltas(int value) {
    _faltas = value;
  }

  set maximoFaltas(int value) {
    _maximoFaltas = value;
  }

  @override
  String toString() {
    return 'DisciplinaBoletim(nome: $_nome, professor: $_professor, situacao: $_situacao, media: $_media, faltas: $_faltas, maximoFaltas: $_maximoFaltas)';
  }
}
