import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/modules/client/client_detail/client_details_page.dart';
import 'package:js_budget/src/modules/client/client_form/client_form_page.dart';
import 'package:js_budget/src/modules/client/clients_page.dart';
import 'package:js_budget/src/modules/client/client_contact_phone/contact_phone_page.dart';

class ClientModule extends FlutterGetItModule {
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
