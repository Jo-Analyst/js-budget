import 'package:js_budget/src/models/budget_model.dart';

class TransformBudgetJson {
  static BudgetModel fromJson(Map<String, dynamic> budget) {
    return BudgetModel(
      id: budget['id'],
      valueTotal: budget['value_total'],
      status: 'Em aberto',
      itemsBudget: budget['items_budget'],
      createdAt: budget['created_at'],
      clientId: budget['client_id'],
      orderId: budget['order_id'],
    );
  }
}
