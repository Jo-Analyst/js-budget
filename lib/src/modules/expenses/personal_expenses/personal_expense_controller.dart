import 'package:js_budget/src/repositories/expense/transform_expense_json.dart';
import 'package:signals/signals.dart';

import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/expense_model.dart';

import 'package:js_budget/src/repositories/expense/personal_expense/personal_repository.dart';

class PersonalExpenseController with Messages {
  final valueExpense = signal(0.0);
  final _data = ListSignal<ExpenseModel>([]);
  ListSignal get data => _data
    ..sort(
      (a, b) => b.id
          .toString()
          .toLowerCase()
          .compareTo(a.id.toString().toLowerCase()),
    );

  final model = signal<ExpenseModel?>(null);

  final PersonalExpenseRepository _expenseRepository;
  PersonalExpenseController({
    required PersonalExpenseRepository expenseRepository,
  }) : _expenseRepository = expenseRepository;

  Future<void> save(ExpenseModel personalExpense) async {
    final result = personalExpense.id == 0
        ? await _expenseRepository.register(personalExpense)
        : await _expenseRepository.update(personalExpense);

    switch (result) {
      case Right(value: ExpenseModel model):
        _data.add(model);
        showSuccess('Despesa cadastrado com sucesso');
      case Right():
        if (personalExpense.id > 0) {
          _deleteItem(personalExpense.id);
        }
        _data.add(personalExpense);
        showSuccess('Despesa alterado com sucesso');
      case Left():
        showError('Houve um erro ao cadastrar o despesa');
    }
  }

  Future<void> deleteExpense(int id) async {
    final result = await _expenseRepository.delete(id);
    switch (result) {
      case Right():
        _deleteItem(id);
        showSuccess('Despesa excluido com sucesso');
      case Left():
        showError('Houve um erro ao excluir a despesa');
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
          _data.add(TransformExpenseJson.fromJson(expense));
        }

      case Left():
        showError('Houver erro ao buscar as despesas');
    }
  }

  List<ExpenseModel> findExpenseByDate(String date) {
    List<ExpenseModel> expenses = _data
        .where((expense) =>
            expense.date.toLowerCase().contains(date.toLowerCase()))
        .toList();
    valueExpense.value = _sumValueExpense(expenses);
    return expenses;
  }

  double _sumValueExpense(List<ExpenseModel> expenses) {
    double valueExpense = 0;
    for (var expense in expenses) {
      valueExpense += expense.value;
    }

    return valueExpense;
  }
}
