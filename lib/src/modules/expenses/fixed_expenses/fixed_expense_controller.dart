import 'package:js_budget/src/models/fixed_expense_model.dart';
import 'package:js_budget/src/repositories/expense/fixed_expense/fixed_repository.dart';
import 'package:signals/signals.dart';

import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/repositories/expense/fixed_expense/transform_fixed_expense_json.dart';

class FixedExpenseController with Messages {
  final _data = ListSignal<FixedExpenseModel>([]);
  ListSignal get data => _data
    ..sort(
      (a, b) => a.type
          .toString()
          .toLowerCase()
          .compareTo(b.type.toString().toLowerCase()),
    );

  final model = signal<FixedExpenseModel?>(null);

  final FixedExpenseRepository _expenseRepository;
  FixedExpenseController({
    required FixedExpenseRepository expenseRepository,
  }) : _expenseRepository = expenseRepository;

  Future<void> save(FixedExpenseModel expense) async {
    final result = expense.id == 0
        ? await _expenseRepository.register(expense)
        : await _expenseRepository.update(expense);

    switch (result) {
      case Right(value: FixedExpenseModel model):
        _data.add(model);
        showSuccess('Despesa cadastrado com sucesso');
      case Right():
        if (expense.id > 0) {
          _deleteItem(expense.id);
        }
        _data.add(expense);
        showSuccess('Despesa alterado com sucesso');
      case Left():
        showError('Houve um erro ao cadastrar o despesa');
    }
  }

  Future<void> deleteMaterial(int id) async {
    final result = await _expenseRepository.delete(id);
    switch (result) {
      case Right():
        _deleteItem(id);
        showSuccess('Despesa excluido com sucesso');
      case Left():
        showError('Houve um erro ao excluir o despesa');
    }
  }

  void _deleteItem(int id) {
    _data.removeWhere((item) => item.id == id);
  }

  Future<void> findExpense() async {
    _data.clear();
    final results = await _expenseRepository.findAll();

    switch (results) {
      case Right(value: List<Map<String, dynamic>> expenses):
        for (var expense in expenses) {
          _data.add(TransformJson.fromJson(expense));
        }

      case Left():
        showError('Houver erro ao buscar o despesa');
    }
  }
}
