import 'package:flutter_test/flutter_test.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/remote/material/get_material_remote.dart';
import 'package:ifg_mobile_estudante/layers/data/dto/materialDTO.dart';
import 'package:ifg_mobile_estudante/layers/data/dto/materialDiciplineDTO.dart';
import 'package:ifg_mobile_estudante/layers/domain/entities/models/material_entity.dart';

void main() {
  group('MaterialDTO', () {
    final jsonMap = {
      'nome': 'Teste Material',
      'tipoDeArquivo': 'PDF',
      'data': '2025-04-01',
      'link': 'http://exemplo.com/arquivo.pdf',
    };

    test('fromJson cria instância correta', () {
      final dto = MaterialDTO.fromJson(jsonMap);
      expect(dto.nome, 'Teste Material');
      expect(dto.tipoDeArquivo, 'PDF');
      expect(dto.link, 'http://exemplo.com/arquivo.pdf');
    });

 

    test('toEntity converte para MaterialEntity corretamente', () {
      final dto = MaterialDTO.fromJson(jsonMap);
      final entity = dto.toEntity();
      expect(entity, isA<Material>());
      expect(entity.nome, 'Teste Material');
      expect(entity.tipoDeArquivo, 'PDF');
      expect(entity.data, DateTime.parse('2025-04-01'));
      expect(entity.link, 'http://exemplo.com/arquivo.pdf');
    });

    test('fromJsonList processa lista de JSON corretamente', () {
      final list = [jsonMap, jsonMap];
      final dtos = MaterialDTO.fromJsonList(list);
      expect(dtos, hasLength(2));
      expect(dtos.first.nome, 'Teste Material');
    });

    test('fromJson lança exceção em JSON inválido', () {
      expect(() => MaterialDTO.fromJson({'nome': 123}), throwsException);
    });
  });

  group('DisciplinaMaterialDTO', () {
    final materialJson = {
      'nome': 'Doc Teste',
      'tipoDeArquivo': 'DOCX',
      'data': '2025-04-05',
      'link': 'http://link.docx',
    };
    final disciplinaJson = {
      'matricula': '20250001',
      'nome': 'TestDisciplina',
      'materiais': [materialJson],
    };

    test('fromJson cria instância correta', () {
      final dto = DisciplinaMaterialDTO.fromJson(disciplinaJson);
      expect(dto.matricula, '20250001');
      expect(dto.nome, 'TestDisciplina');
      expect(dto.materiais, hasLength(1));
      final mat = dto.materiais.first;
      expect(mat.nome, 'Doc Teste');
    });

    test('toJson retorna mapa correto', () {
      final dto = DisciplinaMaterialDTO.fromJson(disciplinaJson);
      final map = dto.toJson();
      expect(map['matricula'], '20250001');
      expect(map['nome'], 'TestDisciplina');
      expect((map['materiais'] as List).first['nome'], 'Doc Teste');
    });

    test('toEntity converte para Disciplina_Material corretamente', () {
      final dto = DisciplinaMaterialDTO.fromJson(disciplinaJson);
      final entity = dto.toEntity();
      expect(entity, isA<Disciplina_Material>());
      expect(entity.nome, 'TestDisciplina');
      expect(entity.materiais, hasLength(1));
      expect(entity.materiais.first, isA<Material>());
    });

    test('fromJsonList processa lista de JSON corretamente', () {
      final list = [disciplinaJson, disciplinaJson];
      final dtos = DisciplinaMaterialDTO.fromJsonList(list);
      expect(dtos, hasLength(2));
      expect(dtos.first.nome, 'TestDisciplina');
    });

    test('fromJson lança exceção em JSON inválido', () {
      expect(() => DisciplinaMaterialDTO.fromJson({'nome': 123}), throwsException);
    });
  });

  group('GetDisciplinasPorMatriculaDataSourceRemoteImpl', () {
    late GetDisciplinasPorMatriculaDataSourceRemoteImpl dataSource;
    const testMatricula = '20250001';

    setUp(() {
      dataSource = GetDisciplinasPorMatriculaDataSourceRemoteImpl();
    });

    test('call retorna lista não-nula de DisciplinaMaterialDTO', () async {
      final result = await dataSource.call(testMatricula);
      expect(result, isNotNull);
      expect(result, isA<List<DisciplinaMaterialDTO?>>());
    });

 

  });
}
