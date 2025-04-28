// layers/data/datasources/get_anos_boletim_datasource_remote_impl.dart

import 'package:ifg_mobile_estudante/layers/data/datasources/get_boletim_por_matricula_datasource.dart';
import 'package:ifg_mobile_estudante/layers/data/dto/ano_boletimDTO.dart';
import 'package:dio/dio.dart';
import 'package:ifg_mobile_estudante/layers/data/dto/discipline_boletimDTO.dart';

class GetAnosBoletimDatasourceRemoteImpl implements GetAnosBoletimDatasource {
  final Dio dio;

  GetAnosBoletimDatasourceRemoteImpl({Dio? dio}) : dio = dio ?? Dio();

  @override
  Future<List<AnoDTO?>?> call(String matricula) async {
    await Future.delayed(const Duration(milliseconds: 200));

    /*
    // Código real futuro (exemplo usando dotenv para pegar URL e token)

    final String url = dotenv.env['URL_AnosBoletim'] ?? '';
    final String token = dotenv.env['API_TOKEN'] ?? '';
    final Map<String, String> dados = {'token': token, 'matricula': matricula};

    try {
      final response = await dio.post(url, data: FormData.fromMap(dados));

      if (response.statusCode == 200) {
        return AnoDTO.fromJsonList(response.data);
      } else {
        print('Falha na requisição: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }
    return null;
    */

    // Mock de dados para ambiente de desenvolvimento/testes
    final mock =
        anosBoletimDataMock.entries.map((entry) {
          final anoNumero = int.parse(entry.key);
          final disciplinas =
              entry.value.map((disciplinaData) {
                return DisciplinaBoletimDTO.fromJson({
                  'nome': disciplinaData['nome'],
                  'professor': disciplinaData['professor'],
                  'situacao': disciplinaData['situacao'],
                  'media': disciplinaData['media'],
                  'faltas': disciplinaData['faltas'],
                  'maximoFaltas': disciplinaData['maximoFaltas'],
                });
              }).toList();

          return AnoDTO(numeroAno: anoNumero, disciplinas: disciplinas);
        }).toList();

    return mock;
  }
}

// Mock de dados dos anos do boletim
final Map<String, List<Map<String, dynamic>>> anosBoletimDataMock = {
  '2023': [
    {
      'nome': 'Matemática',
      'professor': 'Carlos Silva',
      'situacao': 'Aprovado',
      'media': 8.5,
      'faltas': 2,
      'maximoFaltas': 25,
    },
    {
      'nome': 'Português',
      'professor': 'Ana Souza',
      'situacao': 'Aprovado',
      'media': 9.0,
      'faltas': 1,
      'maximoFaltas': 25,
    },
  ],
  '2024': [
    {
      'nome': 'Física',
      'professor': 'João Pereira',
      'situacao': 'Em andamento',
      'media': 7.2,
      'faltas': 3,
      'maximoFaltas': 20,
    },
    {
      'nome': 'Químidca',
      'professor': 'Mariana Costa',
      'situacao': 'Em andamento',
      'media': 7.8,
      'faltas': 1,
      'maximoFaltas': 20,
    },
     {
      'nome': 'Químsica',
      'professor': 'Mariana Costa',
      'situacao': 'Em andamento',
      'media': 7.8,
      'faltas': 1,
      'maximoFaltas': 20,
    },
     {
      'nome': 'Químsica',
      'professor': 'Mariana Costa',
      'situacao': 'Em andamento',
      'media': 7.8,
      'faltas': 1,
      'maximoFaltas': 20,
    },
  ],
    '2025': [
    {
      'nome': 'Física',
      'professor': 'João Pereira',
      'situacao': 'Em andamento',
      'media': 7.2,
      'faltas': 3,
      'maximoFaltas': 20,
    },
    {
      'nome': 'Químidca',
      'professor': 'Mariana Costa',
      'situacao': 'Em andamento',
      'media': 7.8,
      'faltas': 1,
      'maximoFaltas': 20,
    },
     {
      'nome': 'Químsica',
      'professor': 'Mariana Costa',
      'situacao': 'Em andamento',
      'media': 7.8,
      'faltas': 1,
      'maximoFaltas': 20,
    },
     {
      'nome': 'Químsica',
      'professor': 'Mariana Costa',
      'situacao': 'Em andamento',
      'media': 7.8,
      'faltas': 1,
      'maximoFaltas': 20,
    },
  ],
};
