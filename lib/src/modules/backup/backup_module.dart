import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/backup/backup_page.dart';

class BackupModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/db';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/backup': (_) => const BackupPage(),
      };
}
