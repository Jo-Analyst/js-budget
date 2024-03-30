import 'package:flutter/material.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/modules/products/product_form/product_form_page.dart';

mixin ProductFormController on State<ProductFormPage> {
  final nameEC = TextEditingController();
  final descriptionEC = TextEditingController();

  void initializeForm(ProductModel product) {
    nameEC.text = product.name;
    descriptionEC.text = product.description;
  }

  void disposeForm() {
    nameEC.dispose();
    descriptionEC.dispose();
  }

  ProductModel save(int id, String unit) {
    return ProductModel(
      id: id,
      name: nameEC.text.trim(),
      description: descriptionEC.text.trim(),
      unit: unit,
    );
  }
}
