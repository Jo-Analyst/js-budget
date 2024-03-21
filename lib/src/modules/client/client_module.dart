import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/client/client_controller.dart';
import 'package:js_budget/src/modules/client/client_detail/client_details_page.dart';
import 'package:js_budget/src/modules/client/client_form/client_form_page.dart';
import 'package:js_budget/src/modules/client/clients_page.dart';
import 'package:js_budget/src/modules/client/client_contact_phone/contact_phone_page.dart';
import 'package:js_budget/src/repositories/client/client_repository.dart';
import 'package:js_budget/src/repositories/client/client_repository_impl.dart';

class ClientModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<ClientRepository>((i) => ClientRepositoryImpl()),
        Bind.lazySingleton((i) => ClientController(clientRepository: i()))
      ];

  @override
  String get moduleRouteName => '/client';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (context) => const ClientPage(),
        '/register': (context) => const ClientFormPage(),
        '/details': (context) => const ClientDetailsPage(),
        '/contact-phone': (context) => const ContactPhonePage(),
      };
}
