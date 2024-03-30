import 'package:flutter/material.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:js_budget/src/modules/service/service_form/service_form_page.dart';

mixin ServiceFormController on State<ServiceFormPage> {
  final descriptionEC = TextEditingController();

  void initializeForm(ServiceModel product) {
    descriptionEC.text = product.description;
  }

  void disposeForm() {
    descriptionEC.dispose();
  }

  ServiceModel save(int id, String unit) {
    return ServiceModel(
      id: id,
      description: descriptionEC.text.trim(),
    );
  }
}
