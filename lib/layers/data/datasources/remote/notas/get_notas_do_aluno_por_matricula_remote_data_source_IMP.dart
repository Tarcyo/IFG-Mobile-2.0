import 'package:dio/dio.dart';
import '../../get_notasDoAlunoPorMatricula_datasource.dart';
import '../../../dto/gradeDiaryDTO.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GetNotasDoAlunoPorMatriculaDataSourceRemoteImp
    implements GetNotasdoalunopormatriculaDatasource {
  final Dio dio;

  GetNotasDoAlunoPorMatriculaDataSourceRemoteImp({Dio? dio})
    : dio = dio ?? Dio();

  @override
  Future<List<GradeDiaryDTO?>?> call(final String matricula) async {
    final String url =  dotenv.env['URL_Notas'] ?? '';
    final String token = dotenv.env['API_TOKEN'] ?? '';

    final Map<String, String> dados = {'token': token, 'matricula': matricula};

    try {
      final response = await dio.post(url, data: FormData.fromMap(dados));

      if (response.statusCode == 200) {
        return GradeDiaryDTO.fromJsonList(response.data);
      } else {
        print('Falha na requisição: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }

    return null;
  }
}
