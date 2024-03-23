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

  ClientModel saveClient(int clientId, int addressId, int contactId) {
    return ClientModel(
      id: clientId,
      name: nameEC.text.trim(),
      contact: cellPhoneEC.text.trim().isNotEmpty ||
              mailEC.text.trim().isNotEmpty ||
              telePhoneEC.text.trim().isNotEmpty
          ? ContactModel(
              id: contactId,
              cellPhone: cellPhoneEC.text.trim(),
              email: mailEC.text.trim(),
              telePhone: telePhoneEC.text.trim(),
            )
          : null,
      address: districtEC.text.trim().isNotEmpty ||
              streetAddressEC.text.trim().isNotEmpty ||
              numberAddressEC.text.trim().isNotEmpty ||
              cityEC.text.trim().isNotEmpty ||
              stateEC.text.trim().isNotEmpty
          ? AddressModel(
              id: addressId,
              cep: cepEC.text.trim(),
              district: districtEC.text.trim(),
              streetAddress: streetAddressEC.text.trim(),
              numberAddress: numberAddressEC.text.trim(),
              city: cityEC.text.trim(),
              state: stateEC.text.trim(),
            )
          : null,
    );
  }
}
