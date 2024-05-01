import 'package:js_budget/src/models/item_order_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:signals/signals.dart';

class ItemBudgetController {
  final _data = ListSignal<ItemsBudgetModel>([]);
  ListSignal<ItemsBudgetModel> get data => _data;

  void add(List<ItemOrderModel> items) {
    _data.clear();
    for (var item in items) {
      if (item.product != null) {
        _data.add(ItemsBudgetModel(
            product: item.product,
            materialItemsBudget: [],
            fixedExpenseItemsBudget: []));
      }

      if (item.service != null) {
        _data.add(ItemsBudgetModel(
            service: item.service,
            materialItemsBudget: [],
            fixedExpenseItemsBudget: []));
      }
    }
  }
}
