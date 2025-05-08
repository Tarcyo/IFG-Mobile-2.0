import 'package:dio/dio.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/get_materiais_dataSource.dart';
import 'package:ifg_mobile_estudante/layers/data/dto/materialDiciplineDTO.dart';
import 'package:ifg_mobile_estudante/layers/data/dto/materialDTO.dart';

// Implementação remota do datasource para obter disciplinas por matrícula
class GetDisciplinasPorMatriculaDataSourceRemoteImpl
    implements GetDisciplinasPorMatriculaDatasource {
  final Dio dio;

  /// Construtor que permite injeção de um Dio customizado (útil para testes)
  GetDisciplinasPorMatriculaDataSourceRemoteImpl({Dio? dio})
    : dio = dio ?? Dio();

  @override
  Future<List<DisciplinaMaterialDTO?>?> call(final String matricula) async {
    await Future.delayed(Duration(milliseconds: 200));

    /*
// Código original comentado para não ser executado
final String url = dotenv.env['URL_Disciplinas'] ?? '';
final String token = dotenv.env['API_TOKEN'] ?? '';
final Map<String, String> dados = {'token': token, 'matricula': matricula};
try {
  final response = await dio.post(url, data: FormData.fromMap(dados));

  if (response.statusCode == 200) {
    return DisciplinaMaterialDTO.fromJsonList(response.data);
  } else {
    print('Falha na requisição: \${response.statusCode}');
  }
} catch (e) {
  print('Erro durante a requisição: \$e');
}
return null;
*/

    // Retorna dados mockados para desenvolvimento/testes sem alterar a estrutura
    final mock =
        materialsDataMock.entries.map((entry) {
          final disciplina = entry.key;
          final listaMateriais =
              entry.value
                  .map(
                    (m) => MaterialDTO.fromJson({
                      'nome': m['nome'],
                      'tipoDeArquivo': m['tipoDeArquivo'],
                      'data': m['data'],
                      'link': m['link'],
                    }),
                  )
                  .toList();
          return DisciplinaMaterialDTO(
            matricula: matricula,
            nome: disciplina,
            materiais: listaMateriais,
          );
        }).toList();

    return mock;
  }
}

// Mock de materiais por disciplina para testes ou ambiente de desenvolvimento
// As chaves do map devem corresponder aos campos esperados pelo DTO ("nome", "tipoDeArquivo", "data", "link").
final Map<String, List<Map<String, dynamic>>> materialsDataMock = {
  'Matemática': [
    {
      'nome': 'Apostila Álgebra Linear',
      'tipoDeArquivo': 'PDF',
      'data':
          '2025-04-01', // ISO-8601 ou "yyyy-MM-dd" funciona com DateTime.parse
      'link': '',
    },
    {
      'nome': 'Exercícios de Geometria',
      'tipoDeArquivo': 'DOCX',
      'data': '2025-04-05',
      'link': '',
    },
  ],
  'Algoritmos': [
    {
      'nome': 'Estruturas bsadasdsdsddadasdásicas',
      'tipoDeArquivo': 'PDF',
      'data':
          '2025-04-01', // ISO-8601 ou "yyyy-MM-dd" funciona com DateTime.parse
      'link': '',
    },
    {
      'nome': 'Condicionais',
      'tipoDeArquivo': 'DOCX',
      'data': '2025-04-05',
      'link': '',
    },
    {
      'nome': 'Repetição',
      'tipoDeArquivo': 'DOCX',
      'data': '2025-04-05',
      'link': '',
    },
    {
      'nome': 'Funções e Métodos',
      'tipoDeArquivo': 'DOCX',
      'data': '2025-04-05',
      'link': '',
    },
    {
      'nome': 'Boas práticas de programação',
      'tipoDeArquivo': 'DOCX',
      'data': '2025-04-05',
      'link': '',
    },
    {
      'nome': 'Técnicas de programação',
      'tipoDeArquivo': 'DOCX',
      'data': '2025-04-05',
      'link': '',
    },
    {
      'nome': 'Algoritmos de ordenação',
      'tipoDeArquivo': 'DOCX',
      'data': '2025-04-05',
      'link': '',
    },
  ],
  'História': [
    {
      'nome': 'Linha do Tempo das Guerras Mundiais',
      'tipoDeArquivo': 'PDF',
      'data': '2025-04-03',
      'link': '',
    },
  ],
  'Biologia': [
    {
      'nome': 'Material Genética e Evolução',
      'tipoDeArquivo': 'PPT',
      'data': '2025-04-07',
      'link': '',
    },
  ],
  'Química': [
    {
      'nome': 'Tabela Periódica Interativa',
      'tipoDeArquivo': 'HTML',
      'data': '2025-04-02',
      'link': '',
    },
  ],
  'Literatura': [
    {
      'nome': 'Análise de Obras Clássicas',
      'tipoDeArquivo': 'PDF',
      'data': '2025-04-06',
      'link': '',
    },
  ],
};
