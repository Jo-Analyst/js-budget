import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/models/contact_model.dart';
import 'package:js_budget/src/models/profile_model.dart';
import 'package:js_budget/src/modules/profile/profile_form/profile_form_page.dart';

mixin ProfileFormController on State<ProfileFormPage> {
  final fantasyNameEC = TextEditingController();
  final corporateReasonEC = TextEditingController();
  final documentEC = TextEditingController();
  final telePhoneEC = TextEditingController();
  final cellPhoneEC = TextEditingController();
  final cepEC = TextEditingController();
  final mailEC = TextEditingController();
  final streetAddressEC = TextEditingController();
  final districtEC = TextEditingController();
  final numberAddressEC = TextEditingController();
  final cityEC = TextEditingController();
  final stateEC = TextEditingController();
  final salaryExpectationEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');

  void disposeForm() {
    fantasyNameEC.dispose();
    corporateReasonEC.dispose();
    documentEC.dispose();
    telePhoneEC.dispose();
    cellPhoneEC.dispose();
    cepEC.dispose();
    mailEC.dispose();
    districtEC.dispose();
    streetAddressEC.dispose();
    numberAddressEC.dispose();
    cityEC.dispose();
    stateEC.dispose();
    salaryExpectationEC.dispose();
  }

  void initializeForm(ProfileModel profile) {
    fantasyNameEC.text = profile.fantasyName;
    corporateReasonEC.text = profile.corporateReason;
    documentEC.text = profile.document;
    telePhoneEC.text = profile.contact.telePhone;
    cellPhoneEC.text = profile.contact.cellPhone;
    mailEC.text = profile.contact.email;
    cepEC.text = profile.address.cep;
    districtEC.text = profile.address.district;
    streetAddressEC.text = profile.address.streetAddress;
    numberAddressEC.text = profile.address.numberAddress;
    cityEC.text = profile.address.city;
    stateEC.text = profile.address.state;
    salaryExpectationEC.updateValue(profile.salaryExpectation);
  }

  void setCep(AddressModel address, {int addressId = 0}) {
    cepEC.text = address.cep;
    districtEC.text = address.district;
    streetAddressEC.text = address.streetAddress;
    numberAddressEC.text = address.numberAddress;
    cityEC.text = address.city;
    stateEC.text = address.state;
  }

  ProfileModel saveProfile(int id, int contactId, int addressId) {
    return ProfileModel(
      id: id,
      fantasyName: fantasyNameEC.text.trim(),
      corporateReason: corporateReasonEC.text.trim(),
      document: documentEC.text,
      salaryExpectation: salaryExpectationEC.numberValue,
      contact: ContactModel(
        id: contactId,
        cellPhone: cellPhoneEC.text.trim(),
        email: mailEC.text.trim(),
        telePhone: telePhoneEC.text.trim(),
      ),
      address: AddressModel(
        id: addressId,
        cep: cepEC.text.trim(),
        district: districtEC.text.trim(),
        streetAddress: streetAddressEC.text.trim(),
        numberAddress: numberAddressEC.text.trim(),
        city: cityEC.text.trim(),
        state: stateEC.text.trim(),
      ),
    );
  }
}
