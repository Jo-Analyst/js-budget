import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:signals/signals.dart';

import 'package:js_budget/src/models/budget_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/repositories/budget/budget_repository.dart';

class BudgetController with Messages {
  BudgetController({
    required BudgetRepository budgetRepository,
  }) : _budgetRepository = budgetRepository;

  final BudgetRepository _budgetRepository;
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

  Future<void> save() async {
    final results = await _budgetRepository.save(model.value);

    switch (results) {
      case Right():
        showSuccess('Orçamento criado com sucesso');
      case Left():
        showError('Houve um erro ao gerar o orçamento');
    }
  }
}
