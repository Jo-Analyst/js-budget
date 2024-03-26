import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/profile/profile_controller.dart';
import 'package:js_budget/src/repositories/find_cep/find_cep_repository.dart';
import 'package:js_budget/src/repositories/find_cep/find_cep_repository_impl.dart';
import 'package:js_budget/src/repositories/profile/profile_repository.dart';
import 'package:js_budget/src/repositories/profile/profile_repository_impl.dart';
import 'package:js_budget/src/utils/find_cep_controller.dart';

class BindingInitialApplication extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton<ProfileRepository>((i) => ProfileRepositoryImpl()),
        Bind.lazySingleton((i) => ProfileController(profileRepository: i())),
        Bind.lazySingleton<FindCepRepository>((i) => FindCepRepositoryImpl()),
        Bind.lazySingleton((i) => FindCepController(findCepRepository: i())),
      ];
}
