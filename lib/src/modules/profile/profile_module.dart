import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/profile/profile_controller.dart';
import 'package:js_budget/src/modules/profile/profile_detail/profile_detail_page.dart';
import 'package:js_budget/src/modules/profile/profile_form/profile_form_page.dart';
import 'package:js_budget/src/repositories/profile/profile_repository.dart';
import 'package:js_budget/src/repositories/profile/profile_repository_impl.dart';

class ProfileModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => ProfileController(profileRepository: i())),
        Bind.lazySingleton<ProfileRepository>((i) => ProfileRepositoryImpl()),
      ];

  @override
  String get moduleRouteName => '/profile';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (context) => const ProfileDetailsPage(),
        '/save': (context) => const ProfileFormPage()
      };
}
