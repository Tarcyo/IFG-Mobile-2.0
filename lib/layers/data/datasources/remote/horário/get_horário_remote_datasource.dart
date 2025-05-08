// layers/data/datasources/get_dias_da_semana_datasource_remote_impl.dart

import 'package:dio/dio.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/get_hor%C3%A1rio_por_matr%C3%ADcula_datasource.dart';
import 'package:ifg_mobile_estudante/layers/data/dto/diaDaSemanaDTO.dart';
import 'package:ifg_mobile_estudante/layers/data/dto/hor%C3%A1rioDTO.dart';

class GetDiasDaSemanaDataSourceRemoteImpl implements GetDiasDaSemanaDatasource {
  final Dio dio;

  GetDiasDaSemanaDataSourceRemoteImpl({Dio? dio})
      : dio = dio ?? Dio();

  @override
  Future<List<DiaDaSemanaDTO?>?> call(final String matricula) async {
    await Future.delayed(Duration(milliseconds: 200));

    /*
    // Código original comentado para futura integração
    final String url = dotenv.env['URL_DIAS_DA_SEMANA'] ?? '';
    final String token = dotenv.env['API_TOKEN'] ?? '';
    final Map<String, String> dados = {'token': token, 'matricula': matricula};

    try {
      final response = await dio.post(url, data: FormData.fromMap(dados));

      if (response.statusCode == 200) {
        return DiaDaSemanaDTO.fromJsonList(response.data);
      } else {
        print('Falha na requisição: \${response.statusCode}');
      }
    } catch (e) {
      print('Erro durante a requisição: \$e');
    }
    return null;
    */

    // Mock para desenvolvimento/testes com DateTime
    final mock = diasDaSemanaMock.entries.map((entry) {
      final diaAbreviado = entry.key;
      final horarios = entry.value.map((horarioMap) {
        return HorarioDTO.fromJson({
          'inicio': (horarioMap['horarioInicio'] as DateTime).toIso8601String(),
          'fim': (horarioMap['horarioFim'] as DateTime).toIso8601String(),
          'local': horarioMap['local'],
          'disciplina': horarioMap['disciplina'],
          'professor': horarioMap['professor'],
        });
      }).toList();
      return DiaDaSemanaDTO(
        abreviatura: diaAbreviado,
        horarios: horarios,
      );
    }).toList();

    return mock;
  }
}

// Mock de horários por dia da semana
final Map<String, List<Map<String, dynamic>>> diasDaSemanaMock = {
  'Seg': [
    {
      'horarioInicio': DateTime(2025, 4, 28, 7, 0),
      'horarioFim': DateTime(2025, 4, 28, 8, 30),
      'local': 'Sala 101',
      'disciplina': 'Matemática',
      'professor': 'Prof. João',
    },
    {
      'horarioInicio': DateTime(2025, 4, 28, 8, 45),
      'horarioFim': DateTime(2025, 4, 28, 10, 15),
      'local': 'Laboratório 2',
      'disciplina': 'Física',
      'professor': 'Profª. Maria',
    },
  ],
  'Ter': [
    {
      'horarioInicio': DateTime(2025, 4, 29, 7, 0),
      'horarioFim': DateTime(2025, 4, 29, 8, 30),
      'local': 'Sala 102',
      'disciplina': 'História',
      'professor': 'Prof. Carlos',
    },
  ],
  'Qua': [
    {
      'horarioInicio': DateTime(2025, 4, 30, 10, 30),
      'horarioFim': DateTime(2025, 4, 30, 12, 0),
      'local': 'Sala 201',
      'disciplina': 'Química',
      'professor': 'Profª. Ana',
    },
  ],
  'Qui': [
    {
      'horarioInicio': DateTime(2025, 5, 1, 7, 0),
      'horarioFim': DateTime(2025, 5, 1, 8, 30),
      'local': 'Sala 103',
      'disciplina': 'Biologia',
      'professor': 'Prof. Eduardo',
    },
  ],
  'Sex': [
    {
      'horarioInicio': DateTime(2025, 5, 2, 8, 45),
      'horarioFim': DateTime(2025, 5, 2, 10, 15),
      'local': 'Laboratório 3',
      'disciplina': 'Programação',
      'professor': 'Profª. Beatriz',
    },
  ],
};
