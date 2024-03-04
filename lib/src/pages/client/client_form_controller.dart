import 'package:flutter/material.dart';
import 'package:js_budget/src/pages/client/client_form_page.dart';

mixin ClientFormController on State<ClientFormPage> {
  final nameEC = TextEditingController();
  final telePhoneEC = TextEditingController();
  final cellPhoneEC = TextEditingController();
  final cepEC = TextEditingController();
  final mailEC = TextEditingController();
  final streetAddressEC = TextEditingController();
  final numberAddressEC = TextEditingController();
  final cityEC = TextEditingController();
  final stateEC = TextEditingController();

  void disposeForm() {
    nameEC.dispose();
    telePhoneEC.dispose();
    cellPhoneEC.dispose();
    cepEC.dispose();
    mailEC.dispose();
    streetAddressEC.dispose();
    numberAddressEC.dispose();
    cityEC.dispose();
    stateEC.dispose();
  }
}
