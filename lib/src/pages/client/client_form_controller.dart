import 'package:flutter/material.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/pages/client/client_form_page.dart';

mixin ClientFormController on State<ClientFormPage> {
  final nameEC = TextEditingController();
  final telePhoneEC = TextEditingController();
  final cellPhoneEC = TextEditingController();
  final cepEC = TextEditingController();
  final mailEC = TextEditingController();
  final streetAddressEC = TextEditingController();
  final districtEC = TextEditingController();
  final numberAddressEC = TextEditingController();
  final cityEC = TextEditingController();
  final stateEC = TextEditingController();

  void disposeForm() {
    nameEC.dispose();
    telePhoneEC.dispose();
    cellPhoneEC.dispose();
    cepEC.dispose();
    mailEC.dispose();
    districtEC.dispose();
    streetAddressEC.dispose();
    numberAddressEC.dispose();
    cityEC.dispose();
    stateEC.dispose();
  }

  void initializeForm(ClientModel client) {
    nameEC.text = client.name;
    telePhoneEC.text = client.contact?.telePhone ?? '';
    cellPhoneEC.text = client.contact?.cellPhone ?? '';
    mailEC.text = client.contact?.email ?? '';
    cepEC.text = client.address?.cep ?? '';
    districtEC.text = client.address?.district ?? '';
    streetAddressEC.text = client.address?.streetAddress ?? '';
    numberAddressEC.text = client.address?.numberAddress ?? '';
    cityEC.text = client.address?.city ?? '';
    stateEC.text = client.address?.state ?? '';
  }
}
