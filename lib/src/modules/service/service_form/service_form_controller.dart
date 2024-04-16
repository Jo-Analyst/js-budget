import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/modules/service/service_form/service_form_page.dart';

mixin ServiceFormController on State<ServiceFormPage> {
  final descriptionEC = TextEditingController();
  final priceEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');

  void initializeForm(ServiceModel service) {
    descriptionEC.text = service.description;
    priceEC.updateValue(service.price);
  }

  void disposeForm() {
    descriptionEC.dispose();
  }

  ServiceModel save(int id) {
    return ServiceModel(
      id: id,
      description: descriptionEC.text.trim(),
      price: priceEC.numberValue,
    );
  }
}
