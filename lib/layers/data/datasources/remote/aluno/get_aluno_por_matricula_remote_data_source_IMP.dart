import 'package:dio/dio.dart';
import '../../get_aluno_por_matricula_datasource.dart';
import '../../../dto/alunoDTO.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GetAlunoPorMatriculaRemoteDataSourceImp
    implements GetAlunoPorMatriculaDataSource {
  final Dio dio;

  GetAlunoPorMatriculaRemoteDataSourceImp({Dio? dio}) : dio = dio ?? Dio();

  @override
  Future<AlunoDTO?> call(String matricula) async {
    final String token = dotenv.env['API_TOKEN'] ?? '';
    final String url = dotenv.env['URL_Aluno'] ?? '';
    final Map<String, String> dados = {
      'token': token,
      'matricula': matricula,
    };

    try {
      final response = await dio.post(url, data: FormData.fromMap(dados));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.data;
        return AlunoDTO.fromJson(jsonResponse);
      } else {
        print('Falha na requisição: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }

    return null;
  }
}
