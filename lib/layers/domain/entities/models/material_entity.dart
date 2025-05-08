class Material {
  String nome;
  String tipoDeArquivo;
  DateTime data;
  String link;

  Material({
    required this.nome,
    required this.tipoDeArquivo,
    required this.data,
    required this.link,
  });



  // Método toString para exibir as informações em formato de string
  @override
  String toString() {
    return 'Material(nome: $nome, tipoDeArquivo: $tipoDeArquivo, data: ${data.toIso8601String()}, link: $link)';
  }
}

class Disciplina_Material {
  String nome;
  List<Material> materiais;

  Disciplina_Material({
    required this.nome,
    required this.materiais,
  });


  // Método toString para exibir as informações em formato de string
  @override
  String toString() {
    return 'Disciplina(nome: $nome, materiais: [${materiais.join(', ')}])';
  }
}
