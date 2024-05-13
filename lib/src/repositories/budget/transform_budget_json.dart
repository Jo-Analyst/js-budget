import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/client_model.dart';

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
          ),
        );
      }
    }

    return tempBudgets;
  }
}
