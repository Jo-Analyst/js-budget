import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/modules/material/material_form/material_form_page.dart';

mixin MaterialFormController on State<MaterialFormPage> {
  final nameEC = TextEditingController();
  final typeMaterialEC = TextEditingController();
  final quantityInStockEC = TextEditingController();
  final priceMaterialEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final dateOfLastPurchaseEC = TextEditingController();
  final supplierEC = TextEditingController();
  final observationEC = TextEditingController();

  void disposeForm() {
    nameEC.dispose();
    typeMaterialEC.dispose();
    quantityInStockEC.dispose();
    priceMaterialEC.dispose();
    supplierEC.dispose();
    observationEC.dispose();
    dateOfLastPurchaseEC.dispose();
  }

  void initilizeForm(MaterialModel material) {
    nameEC.text = material.name.trim();
    typeMaterialEC.text = material.type?.trim() ?? '';
    quantityInStockEC.text = material.quantity.toString();
    priceMaterialEC.updateValue(material.price);
    supplierEC.text = material.supplier?.trim() ?? '';
    observationEC.text = material.observation?.trim() ?? '';
    dateOfLastPurchaseEC.text = material.dateOfLastPurchase ?? '';
  }

  MaterialModel saveMaterial(int id, String unit, String dateOfPurchase,
      bool isChecked, int quantity, int quantityAdd) {
    int lastQuantity = quantityAdd;
    if (isChecked) {
      lastQuantity = int.parse(quantityInStockEC.text) - quantity;
    } else {
      int stockQuantity = int.parse(quantityInStockEC.text);
      if (stockQuantity > quantity) {
        lastQuantity += stockQuantity - quantity;
      } else {
        lastQuantity -= quantity - stockQuantity;
      }
    }
    return MaterialModel(
      id: id,
      name: nameEC.text,
      type: typeMaterialEC.text,
      unit: unit,
      quantity: int.parse(quantityInStockEC.text),
      lastQuantityAdded: lastQuantity,
      price: priceMaterialEC.numberValue,
      supplier: supplierEC.text,
      observation: observationEC.text,
      dateOfLastPurchase: dateOfPurchase,
    );
  }
}
