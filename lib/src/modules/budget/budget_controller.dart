import 'package:js_budget/src/models/budget_model.dart';
import 'package:signals/signals.dart';

class BudgetController {
  final _data = ListSignal<BudgetModel>([]);
  ListSignal<BudgetModel> get data => _data;

  final model = signal<BudgetModel>(
    BudgetModel(),
  );
}
