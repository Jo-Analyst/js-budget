import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
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

    int? indexBudget;
    for (var budget in budgets) {
      int id = budget['order_id'];

      if (tempBudgets.isEmpty ||
          !tempBudgets.any((budget) => budget.id == id)) {
        tempBudgets.add(
          BudgetModel(
            id: budget['id'] ?? 0,
            valueTotal: budget['value_total'],
            createdAt: budget['created_at'],
            orderId: budget['order_id'],
            status: budget['status'],
            client: ClientModel(id: 0, name: budget['client_name']),
          ),
        );
        indexBudget = indexBudget != null ? indexBudget + 1 : 0;
        tempBudgets[indexBudget].itemsBudget = [];
      }

      final items = ItemsBudgetModel(
        subValue: budget['sub_value'],
        product: budget['product_name'] != null
            ? ProductModel.fromJson({
                // 'id': budget['product_id'],
                'name': budget['product_name'],
              })
            : null,
        service: budget['description'] != null
            ? ServiceModel.fromJson({
                // 'id': budget['service_id'],
                'description': budget['description'],
                'price': budget['price'],
              })
            : null,
        materialItemsBudget: [],
        fixedExpenseItemsBudget: [],
      );

      tempBudgets[indexBudget!].itemsBudget!.add(items);
    }

    return tempBudgets;
  }
}
