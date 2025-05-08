import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/remote/boletim/get_boletim_remote.dart';
import 'package:ifg_mobile_estudante/layers/data/dto/ano_boletimDTO.dart';
import 'package:ifg_mobile_estudante/layers/domain/entities/models/year_of_report.dart';

void main() {
  late GetAnosBoletimDatasourceRemoteImpl dataSource;

  setUp(() {
    dataSource = GetAnosBoletimDatasourceRemoteImpl();
  });

  group('AnoDTO', () {
    final disciplinaJson = {
      'nome': 'Teste Disciplina',
      'professor': 'Prof. X',
      'situacao': 'Aprovado',
      'media': 9.5,
      'faltas': 0,
      'maximoFaltas': 20,
    };
    final anoJson = {
      'numeroAno': 2022,
      'disciplinas': [disciplinaJson],
    };

    test('fromJson deve criar instância correta', () {
      final dto = AnoDTO.fromJson(anoJson);
      expect(dto.numeroAno, 2022);
      expect(dto.disciplinas, isNotEmpty);
      final disc = dto.disciplinas.first;
      expect(disc.nome, 'Teste Disciplina');
      expect(disc.professor, 'Prof. X');
      expect(disc.situacao, 'Aprovado');
      expect(disc.media, 9.5);
      expect(disc.faltas, 0);
      expect(disc.maximoFaltas, 20);
    });

    test('toJson retorna mapa correto', () {
      final dto = AnoDTO.fromJson(anoJson);
      final map = dto.toJson();
      expect(map['numeroAno'], 2022);
      expect(map['disciplinas'], isA<List>());
      final discMap = (map['disciplinas'] as List).first as Map<String, dynamic>;
      expect(discMap['nome'], 'Teste Disciplina');
      expect(discMap['media'], 9.5);
    });

    test('toEntity converte para entidade Ano', () {
      final dto = AnoDTO.fromJson(anoJson);
      final entity = dto.toEntity();
      expect(entity, isA<Ano>());
      expect(entity.numeroAno, 2022);
      expect(entity.disciplinas, isNotEmpty);
      final eDisc = entity.disciplinas.first;
      expect(eDisc.nome, 'Teste Disciplina');
    });

    test('fromJsonList processa lista de JSON corretamente', () {
      final list = [anoJson, anoJson];
      final dtos = AnoDTO.fromJsonList(list);
      expect(dtos, hasLength(2));
      expect(dtos.first.numeroAno, 2022);
    });

    test('fromJson lança exceção para JSON inválido', () {
      expect(() => AnoDTO.fromJson({'numeroAno': 'inválido'}), throwsException);
    });
  });

  group('GetAnosBoletimDatasourceRemoteImpl', () {
    const testMatricula = '123456';

    test('call retorna lista não nula de AnoDTO', () async {
      final result = await dataSource.call(testMatricula);
      expect(result, isNotNull);
      expect(result, isA<List<AnoDTO?>>());
    });

    test('call retorna todos os anos do mock', () async {
      final result = await dataSource.call(testMatricula) as List<AnoDTO>;
      final years = result.map((e) => e.numeroAno).toSet();
      expect(years, containsAll(<int>{2023, 2024, 2025}));
    });

    test('disciplinas correspondem aos dados mockados', () async {
      final result = await dataSource.call(testMatricula) as List<AnoDTO>;
      final ano2023 = result.firstWhere((e) => e.numeroAno == 2023);
      expect(ano2023.disciplinas, hasLength(2));
      expect(ano2023.disciplinas.map((d) => d.nome), containsAll(['Matemática', 'Português']));
      final mat = ano2023.disciplinas.firstWhere((d) => d.nome == 'Matemática');
      expect(mat.professor, 'Carlos Silva');
      expect(mat.media, 8.5);
    });

    test('injetando Dio customizado não afeta retorno mockado', () async {
      final customDio = Dio()..options.baseUrl = 'https://nao-importa';
      final customDataSource = GetAnosBoletimDatasourceRemoteImpl(dio: customDio);
      final result = await customDataSource.call(testMatricula);
      expect(result, isNotNull);
      expect((result as List).length, (await dataSource.call(testMatricula))!.length);
    });
  });
}
