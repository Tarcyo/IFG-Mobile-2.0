import 'package:get_it/get_it.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/get_aluno_por_matricula_datasource.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/get_boletim_por_matricula_datasource.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/get_hor%C3%A1rio_por_matr%C3%ADcula_datasource.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/get_materiais_dataSource.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/get_notasDoAlunoPorMatricula_datasource.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/remote/aluno/get_aluno_por_matricula_remote_data_source_IMP.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/remote/boletim/get_boletim_remote.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/remote/hor%C3%A1rio/get_hor%C3%A1rio_remote_datasource.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/remote/material/get_material_remote.dart';
import 'package:ifg_mobile_estudante/layers/data/datasources/remote/notas/get_notas_do_aluno_por_matricula_remote_data_source_IMP.dart';
import 'package:ifg_mobile_estudante/layers/data/repositories/get_aluno_por_matricula_repository/get_aluno_por_matricula_repository_impl.dart';
import 'package:ifg_mobile_estudante/layers/data/repositories/get_boletm_por_matricula_repository/get_boletim_por_matricula_repository_IMPL.dart';
import 'package:ifg_mobile_estudante/layers/data/repositories/get_hor%C3%A1rio_porMatricula_repository/get_hor%C3%A1rio_por_matr%C3%ADcula_repository_IMPL.dart';
import 'package:ifg_mobile_estudante/layers/data/repositories/get_material_repository/get_material_repository_IMPL.dart';
import 'package:ifg_mobile_estudante/layers/data/repositories/get_notas_do_aluno_por_matricula_repository/get_notas_do_aluno_por_matricula_repository_impl.dart';
import 'package:ifg_mobile_estudante/layers/domain/repositories/get_aluno_por_matricula_repsitory/get_aluno_por_matricula_repository.dart';
import 'package:ifg_mobile_estudante/layers/domain/repositories/get_boletim_por_matricula_repository/get_boletim_por_matricula._repository.dart';
import 'package:ifg_mobile_estudante/layers/domain/repositories/get_hor%C3%A1rio_por_matr%C3%ADcula_repository/get_hor%C3%A1rio_por_matricula_repository.dart';
import 'package:ifg_mobile_estudante/layers/domain/repositories/get_material_repository/get_material_repository.dart';
import 'package:ifg_mobile_estudante/layers/domain/repositories/get_notas_do_aluno_por_matricula_usecase/get_aluno_por_matricula_repository.dart';
import 'package:ifg_mobile_estudante/layers/domain/usecases/get_aluno_por_matricula_usecase/get_aluno_por_matricula_usecase.dart';
import 'package:ifg_mobile_estudante/layers/domain/usecases/get_aluno_por_matricula_usecase/get_aluno_por_matricula_usecase_IMPL.dart';
import 'package:ifg_mobile_estudante/layers/domain/usecases/get_hor%C3%A1rio_por_matr%C3%ADcula_usecase/get_hor%C3%A1rio_por_matr%C3%ADcula.dart';
import 'package:ifg_mobile_estudante/layers/domain/usecases/get_hor%C3%A1rio_por_matr%C3%ADcula_usecase/get_hor%C3%A1rio_por_matricula_usecase_IMPL.dart';
import 'package:ifg_mobile_estudante/layers/domain/usecases/get_materiais_por_matricula/get_materials_usecase.dart';
import 'package:ifg_mobile_estudante/layers/domain/usecases/get_materiais_por_matricula/get_materiial_use_case_IMPL.dart';
import 'package:ifg_mobile_estudante/layers/domain/usecases/get_notas_do_aluno_por_matricula_usecase/get_notas_do_aluno_por_matricula_use_case.dart';
import 'package:ifg_mobile_estudante/layers/domain/usecases/get_notas_do_aluno_por_matricula_usecase/get_notas_do_aluno_por_matricula_usecase_IMPL.dart';
import 'package:ifg_mobile_estudante/layers/domain/usecases/get_report_por_matricula_use_case/get_report_por_matricula_use_case.dart';
import 'package:ifg_mobile_estudante/layers/domain/usecases/get_report_por_matricula_use_case/get_report_por_matricula_use_case_IMPL.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/aluno_controller.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/boletim_controler.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/hor%C3%A1rio_controler.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/material_controler.dart';
import 'package:ifg_mobile_estudante/layers/presentation/controllers/notas_controler.dart';

class Inject {
  static void init() {
    final GetIt getIt = GetIt.instance;

    // Aluno:
    getIt.registerLazySingleton<GetAlunoPorMatriculaDataSource>(
      () => GetAlunoPorMatriculaRemoteDataSourceImp(),
    );

    getIt.registerLazySingleton<GetAlunoPorMatriculaRepository>(
      () => GetAlunoPorMatriculaRepositoryIMPL(getIt()),
    );

    getIt.registerLazySingleton<GetAlunoPorMatriculaUseCase>(
      () => GetAlunoPorMatriculaUseCaseImpl(getIt()),
    );

    getIt.registerFactory<AlunoController>(
      () => AlunoController(getAlunoPorMatriculaUseCase: getIt()),
    );

    // Notas:
    getIt.registerLazySingleton<GetNotasdoalunopormatriculaDatasource>(
      () => GetNotasDoAlunoPorMatriculaDataSourceRemoteImp(),
    );

    getIt.registerLazySingleton<GetNotasDoAlunoPorMatriculaRepository>(
      () => GetNotasDoAlunoPorMatriculaRepositoryIMPL(getIt()),
    );

    getIt.registerLazySingleton<GetNotasDoAlunoPorMatriculaUseCase>(
      () => GetNotasDoAlunoPorMatriculaUseCaseImpl(getIt()),
    );

    getIt.registerFactory<NotasController>(
      () => NotasController(getNotasAlunoPorMatriculaUseCase: getIt()),
    );

    // Disciplinas de Material:
    getIt.registerLazySingleton<GetDisciplinasPorMatriculaDatasource>(
      () => GetDisciplinasPorMatriculaDataSourceRemoteImpl(),
    );

    getIt.registerLazySingleton<GetDisciplinasPorMatriculaRepository>(
      () => GetDisciplinasPorMatriculaRepositoryImpl(getIt()),
    );

    getIt.registerLazySingleton<GetDisciplinasPorMatriculaUseCase>(
      () => GetDisciplinasPorMatriculaUseCaseImpl(getIt()),
    );

    getIt.registerFactory<DisciplinaMaterialController>(
      () => DisciplinaMaterialController(getDisciplinasPorMatriculaUseCase: getIt()),
    );

    // Anos do Boletim:
    getIt.registerLazySingleton<GetAnosBoletimDatasource>( // Registrando o datasource de AnosBoletim
      () => GetAnosBoletimDatasourceRemoteImpl(),
    );

    getIt.registerLazySingleton<GetAnosDoBoletimRepository>(
      () => GetAnosDoBoletimRepositoryImpl(getIt()),
    );

    getIt.registerLazySingleton<GetAnosDoBoletimUseCase>(
      () => GetAnosDoBoletimUseCaseImpl(getIt()),
    );

    getIt.registerFactory<AnosBoletimController>(
      () => AnosBoletimController(getAnosBoletimUseCase: getIt()),
    );

    // Dias da Semana:
    getIt.registerLazySingleton<GetDiasDaSemanaDatasource>(
      () => GetDiasDaSemanaDataSourceRemoteImpl(),
    );

    getIt.registerLazySingleton<GetDiasDaSemanaRepository>(
      () => GetDiasDaSemanaRepositoryImpl(getIt()),
    );

    getIt.registerLazySingleton<GetDiasDaSemanaUseCase>(
      () => GetDiasDaSemanaUseCaseImpl(getIt()),
    );

    getIt.registerFactory<DiasDaSemanaController>(
      () => DiasDaSemanaController(getDiasDaSemanaUseCase: getIt()),
    );
  }
}
