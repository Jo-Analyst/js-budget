import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/share/share_doc.dart';

class ShareModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/share';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const ShareDoc(),
      };
}
