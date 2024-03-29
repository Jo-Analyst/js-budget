import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/modules/material/material_form/material_form_page.dart';

mixin MaterialFormController on State<MaterialFormPage> {
  final nameEC = TextEditingController();
  final typeMaterialEC = TextEditingController();
  final unitMaterialEC = TextEditingController();
  final quantityInStockEC = TextEditingController();
  final priceMaterialEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final dateOfLastPurchaseEC = TextEditingController();
  final supplierEC = TextEditingController();
  final observationEC = TextEditingController();

  void disposeForm() {
    nameEC.dispose();
    typeMaterialEC.dispose();
    unitMaterialEC.dispose();
    quantityInStockEC.dispose();
    priceMaterialEC.dispose();
    supplierEC.dispose();
    observationEC.dispose();
    dateOfLastPurchaseEC.dispose();
  }

  void initilizeForm(MaterialModel material) {
    nameEC.text = material.name.trim();
    typeMaterialEC.text = material.type?.trim() ?? '';
    unitMaterialEC.text = material.unit.trim();
    quantityInStockEC.text = material.quantity.toString();
    priceMaterialEC.updateValue(material.price);
    supplierEC.text = material.supplier?.trim() ?? '';
    observationEC.text = material.observation?.trim() ?? '';
    dateOfLastPurchaseEC.text = material.dateOfLastPurchase ?? '';
  }

  MaterialModel saveMaterial(int id) {
    return MaterialModel(
      id: id,
      name: nameEC.text,
      type: typeMaterialEC.text,
      unit: unitMaterialEC.text,
      quantity: int.parse(quantityInStockEC.text),
      price: priceMaterialEC.numberValue,
      supplier: supplierEC.text,
      observation: observationEC.text,
      dateOfLastPurchase: dateOfLastPurchaseEC.text,
    );
  }
}
