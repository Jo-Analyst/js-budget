import 'package:flutter/material.dart';
import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/contact_model.dart';
import 'package:js_budget/src/modules/client/client_form/client_form_page.dart';

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

  ClientModel saveClient() {
    return ClientModel(
      name: nameEC.text,
      contact: cellPhoneEC.text.isNotEmpty ||
              mailEC.text.isNotEmpty ||
              telePhoneEC.text.isNotEmpty
          ? ContactModel(
              cellPhone: cellPhoneEC.text,
              email: mailEC.text,
              telePhone: telePhoneEC.text,
            )
          : null,
      address: districtEC.text.isNotEmpty ||
              streetAddressEC.text.isNotEmpty ||
              numberAddressEC.text.isNotEmpty ||
              cityEC.text.isNotEmpty ||
              stateEC.text.isNotEmpty
          ? AddressModel(
              cep: cepEC.text,
              district: districtEC.text,
              streetAddress: streetAddressEC.text,
              numberAddress: numberAddressEC.text,
              city: cityEC.text,
              state: stateEC.text,
            )
          : null,
    );
  }
}
