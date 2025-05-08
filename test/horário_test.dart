import 'package:flutter_test/flutter_test.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/remote/hor%C3%A1rio/get_hor%C3%A1rio_remote_datasource.dart';
import 'package:ifg_mobile_estudante/layers/data/dto/diaDaSemanaDTO.dart';
import 'package:ifg_mobile_estudante/layers/data/dto/hor%C3%A1rioDTO.dart';
import 'package:ifg_mobile_estudante/layers/domain/entities/models/schedule_entity.dart';

void main() {
  group('HorarioDTO', () {
    final jsonMap = {
      'inicio': '2025-04-28T07:00:00.000Z',
      'fim': '2025-04-28T08:30:00.000Z',
      'local': 'Sala Teste',
      'disciplina': 'Disciplina Teste',
      'professor': 'Prof. Teste',
    };

    test('fromJson deve criar instância correta', () {
      final dto = HorarioDTO.fromJson(jsonMap);
      expect(dto.inicio, jsonMap['inicio']);
      expect(dto.fim, jsonMap['fim']);
      expect(dto.local, 'Sala Teste');
      expect(dto.disciplina, 'Disciplina Teste');
      expect(dto.professor, 'Prof. Teste');
    });

    test('toJson retorna mapa correto', () {
      final dto = HorarioDTO.fromJson(jsonMap);
      final map = dto.toJson();
      expect(map, jsonMap);
    });

    test('toEntity converte para Horario com DateTime correto', () {
      final dto = HorarioDTO.fromJson(jsonMap);
      final entity = dto.toEntity();
      expect(entity, isA<Horario>());
      expect(entity.inicio, DateTime.parse(jsonMap['inicio']??""));
      expect(entity.fim, DateTime.parse(jsonMap['fim'] ??""));
      expect(entity.local, 'Sala Teste');
      expect(entity.disciplina, 'Disciplina Teste');
      expect(entity.professor, 'Prof. Teste');
    });

    test('fromJsonList processa lista de JSON corretamente', () {
      final list = [jsonMap, jsonMap];
      final dtos = HorarioDTO.fromJsonList(list);
      expect(dtos, hasLength(2));
      expect(dtos.first.disciplina, 'Disciplina Teste');
    });
  });

  group('GetDiasDaSemanaDataSourceRemoteImpl', () {
    late GetDiasDaSemanaDataSourceRemoteImpl dataSource;
    const testMatricula = '20250001';

    setUp(() {
      dataSource = GetDiasDaSemanaDataSourceRemoteImpl();
    });

    test('call retorna lista não-nula de DiaDaSemanaDTO', () async {
      final result = await dataSource.call(testMatricula);
      expect(result, isNotNull);
      expect(result, isA<List<DiaDaSemanaDTO?>>());
    });

    test('inclui todos os dias do mock', () async {
      final result = await dataSource.call(testMatricula) as List<DiaDaSemanaDTO>;
      final dias = result.map((d) => d.abreviatura.toUpperCase()).toSet();
      expect(dias, containsAll({'SEG', 'TER', 'QUA', 'QUI', 'SEX'}));
    });

  
  });
}
