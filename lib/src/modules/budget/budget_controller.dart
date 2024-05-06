import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:signals/signals.dart';

class BudgetController {
  final _data = ListSignal<BudgetModel>([]);
  ListSignal<BudgetModel> get data => _data;

  final model = signal<BudgetModel>(
    BudgetModel(),
  );

  double sumValueProducts(ListSignal<ItemsBudgetModel> data) {
    double value = 0.0;
    data.asMap().forEach((key, item) {
      if (item.product != null) {
        value += item.subValue;
      }
    });
    return value;
  }
}
