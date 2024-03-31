import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/request/request_detail/request_detail_page.dart';
import 'package:js_budget/src/modules/request/request_page.dart';

class RequestModules extends FlutterGetItModule {
  @override
  String get moduleRouteName => '/request';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const RequestPage(),
        '/details': (_) => const RequestDetailPage(),
      };
}
