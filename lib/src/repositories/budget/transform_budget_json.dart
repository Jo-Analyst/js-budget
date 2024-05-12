import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';

class TransformBudgetJson {
  static BudgetModel fromJson(Map<String, dynamic> budget) {
    return BudgetModel(
      id: budget['id'],
      valueTotal: budget['value_total'],
      status: 'Em aberto',
      itemsBudget: budget['items_budget'],
      createdAt: budget['created_at'],
      client: budget['client'],
      orderId: budget['order_id'],
    );
  }

  static List<BudgetModel> fromJsonAfterDataSearch(
      List<Map<String, dynamic>> budgets) {
    List<BudgetModel> tempBudgets = [];
    List<ItemsBudgetModel> tempItemsBudget = [];

    int? indexBudget;
    for (var budget in budgets) {
      int id = budget['id'], itembudgetId = budget['item_budget_id'];

      if (tempBudgets.isEmpty ||
          !tempBudgets.any((budget) => budget.id == id)) {
        tempBudgets.add(
          BudgetModel(
              id: budget['id'] ?? 0,
              valueTotal: budget['value_total'],
              createdAt: budget['created_at'],
              orderId: budget['order_id'],
              status: budget['status'],
              client: ClientModel(
                id: 0,
                name: budget['client_name'],
              ),
              itemsBudget: []),
        );
        indexBudget = indexBudget != null ? indexBudget + 1 : 0;
      }

      // final items = ItemsBudgetModel(
      //   id: budget['item_budget_id'],
      //   subValue: budget['sub_value'],
      //   product: budget['product_name'] != null
      //       ? ProductModel.fromJson({
      //           // 'id': budget['product_id'],
      //           'name': budget['product_name'],
      //         })
      //       : null,
      //   service: budget['description'] != null
      //       ? ServiceModel.fromJson({
      //           // 'id': budget['service_id'],
      //           'description': budget['description'],
      //           'price': budget['price'],
      //         })
      //       : null,
      //   materialItemsBudget: _getMaterialItem(budgets, itembudgetId),
      //   fixedExpenseItemsBudget: [],
      // // );
      // tempItemsBudget.add(items);
      tempBudgets[indexBudget!].itemsBudget = tempItemsBudget;
    }

    _getItemsBudget(tempBudgets, budgets);
    _teste(tempItemsBudget, budgets);
    return tempBudgets;
  }

  static List<ItemsBudgetModel> _teste(
      List<ItemsBudgetModel> itemsBudget, List<Map<String, dynamic>> budgets) {
    List<ItemsBudgetModel> tempItemsBudget = [];

    itemsBudget.asMap().forEach((index, item) {
      for (var budget in budgets) {
        if (budget['item_budget_id'] == item.id &&
            budget['product_name'] != null) {
          var materialName = budget['material_name'];
        }
      }
    });

    return [];
  }

  static List<MaterialItemsBudgetModel> _getMaterialItem(
      List<Map<String, dynamic>> budgets, int itembudgetId) {
    List<MaterialItemsBudgetModel> tempMaterial = [];
    for (var budget in budgets) {
      if (budget['item_budget_id'] == itembudgetId &&
          budget['product_name'] != null) {
        var materialName = budget['material_name'];
        // Verifica se o material já existe na lista
        var alreadyExists =
            tempMaterial.any((item) => item.material.name == materialName);
        // Se não existir, adiciona na lista
        if (!alreadyExists) {
          tempMaterial.add(
            MaterialItemsBudgetModel(
              value: budget['value'] ?? 0,
              material: MaterialModel(
                name: materialName,
                unit: 'unit',
                price: 0,
                quantity: 0,
              ),
            ),
          );
        }
      }
    }
    return tempMaterial;
  }

  static void _getItemsBudget(
      List<BudgetModel> budgetsModel, List<Map<String, dynamic>> budgets) {
    List<BudgetModel> tempBudgets = [];
    List<ItemsBudgetModel> tempItemsBudget = [];
    budgetsModel.asMap().forEach((index, item) {
      for (var budget in budgets) {
        // if(budget['item_budget_id'] == item.)
        if (item.itemsBudget.isEmpty ||
            item.itemsBudget
                .any((element) => element.budgetId == budget['id'])) {
          budgetsModel[index].itemsBudget.add(
                ItemsBudgetModel(
                  id: budget['item_budget_id'],
                  subValue: budget['sub_value'],
                  product: budget['product_name'] != null
                      ? ProductModel.fromJson({
                          'id': budget['product_id'],
                          'name': budget['product_name'],
                        })
                      : null,
                  service: budget['description'] != null
                      ? ServiceModel.fromJson({
                          'id': budget['service_id'],
                          'description': budget['description'],
                          'price': budget['price'],
                        })
                      : null,
                  materialItemsBudget: [],
                  fixedExpenseItemsBudget: [],
                ),
              );
        }
      }
      print(budgetsModel[index].toJson());
    });
  }
}
