import 'package:flutter/material.dart';
import 'package:js_budget/src/models/products_model.dart';
import 'package:js_budget/src/modules/products/product_form/product_form_page.dart';

mixin ProductFormController on State<ProductFormPage> {
  final nameEC = TextEditingController();
  final descriptionEC = TextEditingController();

  void initialForm(ProductsModel product) {
    nameEC.text = product.name;
    descriptionEC.text = product.detail;
  }

  void disposeForm() {
    nameEC.dispose();
    descriptionEC.dispose();
  }
}
