import 'package:flutter/material.dart';
import 'package:js_budget/src/pages/client/client_registration_page.dart';

mixin ClientFormController on State<ClientRegistrationPage> {
  final nameEC = TextEditingController();
  final phoneEC = TextEditingController();
  final streetAddressEC = TextEditingController();
  final numberAddressEC = TextEditingController();
  final cityEC = TextEditingController();
  final stateEC = TextEditingController();

  void disposeForm() {
    nameEC.dispose();
    phoneEC.dispose();
    streetAddressEC.dispose();
    numberAddressEC.dispose();
    cityEC.dispose();
    stateEC.dispose();
  }
}
