import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/profile/profile_detail/profile_detail_page.dart';
import 'package:js_budget/src/modules/profile/profile_form/profile_form_page.dart';

class ProfileModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [];

  @override
  String get moduleRouteName => '/profile';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (context) => const ProfileDetailsPage(),
        '/form': (context) => const ProfileFormPage()
      };
}
