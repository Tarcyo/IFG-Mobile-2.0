import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/remote/notas/get_notas_do_aluno_por_matricula_remote_data_source_IMP.dart';
import 'package:ifg_mobile_estudante/layers/data/dto/gradeDiaryDTO.dart';
import 'package:ifg_mobile_estudante/layers/domain/entities/models/gradeDiary_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late GetNotasDoAlunoPorMatriculaDataSourceRemoteImp dataSource;

  setUpAll(() {
    dotenv.testLoad(fileInput: '''
API_TOKEN=test_token
URL_Notas=https://example.com/api/notas
''');
  });

  setUp(() {
    mockDio = MockDio();
    dataSource = GetNotasDoAlunoPorMatriculaDataSourceRemoteImp(dio: mockDio);
  });

  group('GradeDiaryDTO', () {
    final jsonMap = {
      'disciplina': 'Matemática',
      'nota_1': 8.0,
      'nota_2': 7.5,
      'nota_3': null,
      'nota_4': 9.0,
      'nota_final': 8.17,
      'situacao_texto': 'Aprovado',
    };

    test('fromJson cria instância correta', () {
      final dto = GradeDiaryDTO.fromJson(jsonMap);
      expect(dto.disciplina, 'Matemática');
      expect(dto.nota1, 8.0);
      expect(dto.nota2, 7.5);
      expect(dto.nota3, isNull);
      expect(dto.nota4, 9.0);
      expect(dto.notaFinal, 8.17);
      expect(dto.situacaoTexto, 'Aprovado');
    });

    test('toJson retorna mapa correto', () {
      final dto = GradeDiaryDTO.fromJson(jsonMap);
      final map = dto.toJson();
      expect(map['disciplina'], 'Matemática');
      expect(map['nota_1'], 8.0);
      expect(map['nota_3'], isNull);
      expect(map['situacao_texto'], 'Aprovado');
    });

    test('toEntity converte para GradeDiaryEntity corretamente', () {
      final dto = GradeDiaryDTO.fromJson(jsonMap);
      final entity = dto.toEntity();
      expect(entity, isA<GradeDiaryEntity>());
      expect(entity.nota1, '8.0');
      expect(entity.nota3, isNull);
      expect(entity.situacao, 'Aprovado');
    });

    test('fromJsonList processa lista de JSON corretamente', () {
      final list = [jsonMap, jsonMap];
      final dtos = GradeDiaryDTO.fromJsonList(list);
      expect(dtos, hasLength(2));
      expect(dtos.first.disciplina, 'Matemática');
    });

    test('fromJson lança exceção para JSON inválido', () {
      expect(() => GradeDiaryDTO.fromJson({'nota_1': 'inválido'}), throwsException);
    });
  });

  group('GetNotasDoAlunoPorMatriculaDataSourceRemoteImp', () {
    const tMatricula = '20250001';
    final tJsonList = [
      {
        'disciplina': 'Portugues',
        'nota_1': 9.0,
        'nota_2': 8.0,
        'nota_3': 7.0,
        'nota_4': 6.0,
        'nota_final': 7.5,
        'situacao_texto': 'Aprovado',
      }
    ];

    test('retorna lista de DTO quando statusCode 200', () async {
      final response = Response(
        data: tJsonList,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => response);

      final result = await dataSource.call(tMatricula);
      expect(result, isA<List<GradeDiaryDTO>>());
    });

    test('retorna null quando statusCode != 200', () async {
      final response = Response(
        data: {'error': 'fail'},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      );
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => response);

      final result = await dataSource.call(tMatricula);
      expect(result, isNull);
    });

    test('retorna null ao lançar exceção', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenThrow(DioError(requestOptions: RequestOptions(path: ''), error: 'Network'));

      final result = await dataSource.call(tMatricula);
      expect(result, isNull);
    });
  });
}
