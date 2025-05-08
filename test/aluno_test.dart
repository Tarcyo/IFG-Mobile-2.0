import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/remote/aluno/get_aluno_por_matricula_remote_data_source_IMP.dart';
import 'package:ifg_mobile_estudante/layers/data/dto/alunoDTO.dart';
import 'package:ifg_mobile_estudante/layers/domain/entities/models/aluno_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  // Load environment variables for tests to avoid NotInitializedError
  setUpAll(() {
    dotenv.testLoad(
      fileInput: '''
API_TOKEN=test_token
URL_Aluno=https://example.com/api/aluno
''',
    );
  });

  late MockDio mockDio;
  late GetAlunoPorMatriculaRemoteDataSourceImp dataSource;

  const jsonMap = {
    'matricula': '12345',
    'nome': 'João Silva',
    'nome_pai': 'Carlos Silva',
    'nome_mae': 'Maria Silva',
    'curso': 'Engenharia',
    'turno': 'Matutino',
    'modalidade': 'Presencial',
    'ano': 2021,
    'periodo_letivo': 2,
    'polo': 'Campus Centro',
    'data_inicio': '2021-03-01T00:00:00.000Z',
    'data_fim': '2025-12-31T00:00:00.000Z',
    'matriz': '2021',
    'situacao': 'Ativo',
    'full_image_url': 'https://example.com/foto.jpg',
  };

  setUp(() {
    mockDio = MockDio();
    dataSource = GetAlunoPorMatriculaRemoteDataSourceImp(dio: mockDio);
  });

  group('AlunoDTO', () {
    test('fromJson cria instância correta', () {
      final dto = AlunoDTO.fromJson(jsonMap);

      expect(dto.matricula, '12345');
      expect(dto.nome, 'João Silva');
      expect(dto.nomePai, 'Carlos Silva');
      expect(dto.nomeMae, 'Maria Silva');
      expect(dto.curso, 'Engenharia');
      expect(dto.turno, 'Matutino');
      expect(dto.modalidade, 'Presencial');
      expect(dto.ano, 2021);
      expect(dto.periodoLetivo, 2);
      expect(dto.polo, 'Campus Centro');
      expect(dto.dataInicio, DateTime.parse('2021-03-01T00:00:00.000Z'));
      expect(dto.dataFim, DateTime.parse('2025-12-31T00:00:00.000Z'));
      expect(dto.matriz, '2021');
      expect(dto.situacao, 'Ativo');
      expect(dto.fullImageUrl, 'https://example.com/foto.jpg');
    });

    test('toJson retorna mapa correto', () {
      final dto = AlunoDTO.fromJson(jsonMap);
      final map = dto.toJson();

      expect(map['dataInicio'], '2021-03-01T00:00:00.000Z');
      expect(map['dataFim'], '2025-12-31T00:00:00.000Z');
      expect(map['nome'], 'João Silva');
      expect(map['fullImageUrl'], 'https://example.com/foto.jpg');
    });

    test('fromEntity e toEntity preservam dados', () {
      final entity = AlunoEntity(
        matricula: '111',
        nome: 'Teste',
        nomePai: 'Pai',
        nomeMae: 'Mae',
        curso: 'Curso',
        turno: 'Noturno',
        modalidade: 'EAD',
        ano: 2020,
        periodoLetivo: 1,
        polo: 'Outro',
        dataInicio: DateTime(2020, 1, 1),
        dataFim: DateTime(2024, 12, 31),
        matriz: '2020',
        situacao: 'Inativo',
        fullImageUrl: 'http://...jpg',
      );

      final dto = AlunoDTO.fromEntity(entity);
      final backEntity = dto.toEntity();

      expect(backEntity.getMatricula, entity.getMatricula);
      expect(backEntity.getNome, entity.getNome);
      expect(backEntity.getFullImageUrl, entity.getFullImageUrl);
    });

    test('toString contém informações esperadas', () {
      final dto = AlunoDTO.fromJson(jsonMap);
      final str = dto.toString();

      expect(str, contains('matricula: 12345'));
      expect(str, contains('nome: João Silva'));
    });
    test('fromJson lida com campos nulos corretamente', () {
      final dto = AlunoDTO.fromJson({
        'matricula': '999',
        'nome': 'Sem Pai',
        'nome_mae': 'Mãe Teste',
        'curso': 'Curso Teste',
        'turno': 'Integral',
        'modalidade': 'Presencial',
        'ano': 2023,
        'periodo_letivo': 1,
        'data_inicio': null,
        'data_fim': null,
        'matriz': '2023',
        'situacao': 'Ativo',
        'full_image_url': null,
      });

      expect(dto.nomePai, isNull);
      expect(dto.dataInicio, isNull);
      expect(dto.fullImageUrl, isNull);
    });
    test('toJson inclui campos nulos corretamente', () {
      final dto = AlunoDTO(
        matricula: '888',
        nome: 'Fulano',
        nomePai: null,
        nomeMae: 'Fulana',
        curso: 'Direito',
        turno: 'Noturno',
        modalidade: 'EAD',
        ano: 2022,
        periodoLetivo: 2,
        polo: null,
        dataInicio: null,
        dataFim: null,
        matriz: '2022',
        situacao: 'Trancado',
        fullImageUrl: null,
      );

      final json = dto.toJson();

      expect(json['nomePai'], isNull);
      expect(json['dataInicio'], isNull);
      expect(json['polo'], isNull);
    });
    test('dois DTOs com mesmo conteúdo não são iguais sem Equatable', () {
      final dto1 = AlunoDTO.fromJson(jsonMap);
      final dto2 = AlunoDTO.fromJson(jsonMap);

      expect(
        dto1 == dto2,
        isFalse,
      );
    });
    test('fromEntity e toEntity mantêm consistência total', () {
      final original = AlunoDTO.fromJson(jsonMap);
      final roundTrip = AlunoDTO.fromEntity(original.toEntity());

      expect(roundTrip.toJson(), original.toJson());
    });
    test('fromJson lança erro se campo obrigatório estiver ausente', () {
      final invalidJson = Map<String, dynamic>.from(jsonMap)
        ..remove('matricula');

      expect(() => AlunoDTO.fromJson(invalidJson), throwsA(isA<TypeError>()));
    });
  });

  group('GetAlunoPorMatriculaRemoteDataSourceImp', () {
    const tMatricula = '12345';
    final tJson = jsonMap;

    test('retorna AlunoDTO quando response statusCode 200', () async {
      final response = Response(
        data: tJson,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(
        () => mockDio.post(any(), data: any(named: 'data')),
      ).thenAnswer((_) async => response);

      final result = await dataSource.call(tMatricula);
      expect(result, isA<AlunoDTO>());
      expect(result?.matricula, tMatricula);
    });

    test('retorna null quando statusCode diferente de 200', () async {
      final response = Response(
        data: {'error': 'fail'},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      );

      when(
        () => mockDio.post(any(), data: any(named: 'data')),
      ).thenAnswer((_) async => response);

      final result = await dataSource.call(tMatricula);
      expect(result, isNull);
    });

    test('retorna null ao lançar exceção', () async {
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
          error: 'Network error',
        ),
      );

      final result = await dataSource.call(tMatricula);
      expect(result, isNull);
    });
  });

  group('GetAlunoPorMatriculaRemoteDataSourceImp (integração)', () {
    late GetAlunoPorMatriculaRemoteDataSourceImp realDataSource;

    setUpAll(() async {
      // Load real environment variables from .env
      await dotenv.load(fileName: '.env');
    });

    setUp(() {
      realDataSource = GetAlunoPorMatriculaRemoteDataSourceImp();
    });

    test(
      'retorna aluno Tarcyo Guilherme Maia Borges para matrícula 20211030180055',
      () async {
        final result = await realDataSource.call('20211030180055');
        expect(result, isNotNull);
        expect(result!.nome, 'Tárcyo Guilherme Maia Borges');
      },
      timeout: Timeout(Duration(seconds: 10)),
    );
  });
}
