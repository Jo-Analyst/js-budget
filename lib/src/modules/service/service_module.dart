import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/service/service_controller.dart';
import 'package:js_budget/src/modules/service/service_detail/service_detail_page.dart';
import 'package:js_budget/src/modules/service/service_form/service_form_page.dart';
import 'package:js_budget/src/modules/service/service_page.dart';
import 'package:js_budget/src/repositories/service/service_repository.dart';
import 'package:js_budget/src/repositories/service/service_repository_impl.dart';

class ServiceModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<ServiceRepository>((i) => ServiceRepositoryImpl()),
        Bind.lazySingleton((i) => ServiceController(serviceRepository: i()))
      ];
  @override
  String get moduleRouteName => '/service';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (_) => const ServicePage(),
        '/save': (_) => const ServiceFormPage(),
        '/details': (_) => const ServiceDetailPage()
      };
}
