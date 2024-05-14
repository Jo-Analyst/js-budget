import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';

class TransformItemBudgetJson {
  static List<ItemsBudgetModel> fromJsonAfterSearchingProductAndServiceData(
      List<Map<String, dynamic>> itemBudgets) {
    List<ItemsBudgetModel> tempItemsBudget = [];

    for (var itemBudget in itemBudgets) {
      int id = itemBudget['id'];

      if (tempItemsBudget.isEmpty ||
          !tempItemsBudget.any((itemBudget) => itemBudget.id == id)) {
        tempItemsBudget.add(
          ItemsBudgetModel(
              id: itemBudget['id'] ?? 0,
              subValue: itemBudget['sub_value'],
              unitaryValue: itemBudget['unitary_value'],
              quantity: itemBudget['quantity'] ?? 1,
              product: itemBudget['product_name'] != null
                  ? ProductModel(
                      id: 0,
                      name: itemBudget['product_name'],
                    )
                  : null,
              service: itemBudget['service_description'] != null
                  ? ServiceModel(
                      description: itemBudget['service_description'],
                      price: itemBudget['price'])
                  : null,
              materialItemsBudget: [],
              fixedExpenseItemsBudget: []),
        );
      }
    }

    return tempItemsBudget;
  }

  static List<MaterialItemsBudgetModel> fromJsonAfterSearchingMaterialData(
      List<Map<String, dynamic>> materials) {
    List<MaterialItemsBudgetModel> tempMaterialItems = [];

    for (var material in materials) {
      tempMaterialItems.add(
        MaterialItemsBudgetModel(
          quantity: material['quantity'],
          value: material['value'],
          material: MaterialModel(
            name: material['name'],
          ),
        ),
      );
    }

    return tempMaterialItems;
  }
}
