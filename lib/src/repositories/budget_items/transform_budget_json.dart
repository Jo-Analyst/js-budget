import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/models/product_model.dart';

class TransformItemBudgetJson {
  // static BudgetModel fromJson(Map<String, dynamic> budget) {
  //   return BudgetModel(
  //     id: budget['id'],
  //     valueTotal: budget['value_total'],
  //     status: 'Em aberto',
  //     itemsBudget: budget['items_budget'],
  //     createdAt: budget['created_at'],
  //     client: budget['client'],
  //     orderId: budget['order_id'],
  //   );
  // }

  static List<ItemsBudgetModel> fromJsonAfterDataSearch(
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
              product: ProductModel(
                id: 0,
                name: itemBudget['product_name'],
              ),
              materialItemsBudget: [],
              fixedExpenseItemsBudget: []),
        );
      }
    }

    return tempItemsBudget;
  }
}
