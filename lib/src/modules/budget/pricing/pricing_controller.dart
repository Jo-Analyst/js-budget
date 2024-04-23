import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/material_model.dart';

class PricingController with Messages {
  bool validate(List<MaterialItemsBudgetModel> materials) {
    if (materials.isEmpty) {
      showInfo('Informe os materiais que será adicionado no orçamento');
    }

    return materials.isNotEmpty;
  }

  void calculateTotalMaterial(List<MaterialModel> materials){

  }
}
