import 'package:ifg_mobile_estudante/app/app_config_class.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/already_auto_logged_bool_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/aluno_entity_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/notas_list_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/will_auto_login_bool_Provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
List<SingleChildWidget> getProviders(AppConfig config) {
  return [
    ChangeNotifierProvider(create: (_) => AutoLoginProvider(config.autoLogin)),
    ChangeNotifierProvider(create: (_) => AlreadyAutoLogged()),
    ChangeNotifierProvider(
      create: (_) => AlunoControllerProvider(config.alunoController),
    ),
    ChangeNotifierProvider(
      create: (_) => NotasControlerProvider(config.notasController),
    ),
  ];
}