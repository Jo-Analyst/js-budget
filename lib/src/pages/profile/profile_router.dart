import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/pages/profile/profile_page.dart';

class ProfileRouter extends FlutterGetItPageRouter {
  const ProfileRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [];

  @override
  String get routeName => '/profile';

  @override
  WidgetBuilder get view => (_) => const ProfilePage();
}
