import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/profile/profile_controller.dart';
import 'package:js_budget/src/repositories/profile/profile_repository.dart';
import 'package:js_budget/src/repositories/profile/profile_repository_impl.dart';

class BindingInitialApplication extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton((i) => ProfileController(profileRepository: i())),
        Bind.lazySingleton<ProfileRepository>((i) => ProfileRepositoryImpl()),
      ];
}
