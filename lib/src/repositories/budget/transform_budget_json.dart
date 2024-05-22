import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/fixed_expense_items_budget_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/models/payment_model.dart';
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

    int? index;
    for (var budget in budgets) {
      int id = budget['id'];

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
              payment: budget['specie'] != null
                  ? PaymentModel.fromJson(
                      {
                        'specie': budget['specie'],
                        'number_of_installments':
                            budget['number_of_installments'] as int
                      },
                    )
                  : null),
        );
        index = index != null ? index + 1 : 0;
        tempBudgets[index].itemsBudget = [];
      }

      final items = ItemsBudgetModel(
        id: budget['item_budget_id'],
        budgetId: budget['id'],
        subValue: budget['sub_value'],
        unitaryValue: budget['unitary_value'],
        quantity: budget['quantity'] ?? 1,
        product: budget['product_name'] != null
            ? ProductModel.fromJson({
                'id': 0,
                'name': budget['product_name'],
                'description': '',
                'unit': '',
                'quantity': 1
              })
            : null,
        service: budget['description'] != null
            ? ServiceModel.fromJson({
                'id': 0,
                'description': budget['description'],
                'price': budget['price'],
                'quantity': 1
              })
            : null,
        materialItemsBudget: [],
        fixedExpenseItemsBudget: [],
      );

      if (tempBudgets[index!].itemsBudget!.isEmpty ||
          !tempBudgets[index]
              .itemsBudget!
              .any((item) => item.product?.name == budget['product_name'])) {
        final (material, expense) = getMaterialAndFixed(items, budgets);
        items.materialItemsBudget = material;
        items.fixedExpenseItemsBudget = expense;
        tempBudgets[index].itemsBudget!.add(items);
      }
      print(budget['specie']);
      print(tempBudgets[index].payment?.toJson());
    }

    return tempBudgets;
  }

  static (
    List<MaterialItemsBudgetModel> material,
    List<FixedExpenseItemsBudgetModel> expense
  ) getMaterialAndFixed(
      ItemsBudgetModel itemBudget, List<Map<String, dynamic>> budgets) {
    for (var budget in budgets) {
      if (itemBudget.id == budget['item_budget_id'] &&
          !itemBudget.materialItemsBudget.any(
              (element) => element.material.name == budget['material_name']) &&
          budget['product_name'] != null) {
        itemBudget.materialItemsBudget.add(
          MaterialItemsBudgetModel(
            quantity: budget['material_quantity'] ?? 1,
            value: budget['value'],
            itemBudgetId: itemBudget.id,
            material: MaterialModel(
              name: budget['material_name'],
            ),
          ),
        );
      }

      if (itemBudget.id == budget['item_budget_id'] &&
          !itemBudget.fixedExpenseItemsBudget
              .any((element) => element.type == budget['type']) &&
          budget['type'] != null) {
        itemBudget.fixedExpenseItemsBudget.add(
          FixedExpenseItemsBudgetModel(
            accumulatedValue: budget['accumulated_value'],
            itemBudgetId: itemBudget.id,
            type: budget['type'],
          ),
        );
      }
    }
    return (itemBudget.materialItemsBudget, itemBudget.fixedExpenseItemsBudget);
  }
}
