import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/repositories/expense/workshop_expense/workshop_repository.dart';
import 'package:js_budget/src/repositories/expense/transform_expense_json.dart';
import 'package:signals/signals.dart';

import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';

class WorkshopExpenseController with Messages {
  final valueWorkshopExpense = signal(0.0);
  final _data = ListSignal<ExpenseModel>([]);
  ListSignal get data => _data
    ..sort(
      (a, b) => b.id
          .toString()
          .toLowerCase()
          .compareTo(a.id.toString().toLowerCase()),
    );

  final model = signal<ExpenseModel?>(null);

  final WorkshopExpenseRepository _expenseRepository;
  WorkshopExpenseController({
    required WorkshopExpenseRepository expenseRepository,
  }) : _expenseRepository = expenseRepository;

  Future<void> save(ExpenseModel expense) async {
    final result = expense.id == 0
        ? await _expenseRepository.register(expense)
        : await _expenseRepository.update(expense);

    switch (result) {
      case Right(value: ExpenseModel model):
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

  Future<List<ExpenseModel>> findExpenseDescription(String description) async {
    final results = await _expenseRepository.findByDescription(description);
    List<ExpenseModel> expensesModel = [];

    switch (results) {
      case Right(value: var expenses):
        for (var expense in expenses) {
          expensesModel.add(TransformExpenseJson.fromJson(expense));
        }
      case Left():
        showError('Houver erro ao buscar a conta $description');
    }

    return expensesModel;
  }

  Future<ExpenseModel?> findLastExpenseType(String type) async {
    final results = await _expenseRepository.findMaxByDescription(type);
    ExpenseModel? expenseModel;

    switch (results) {
      case Right(value: var expenses):
        expenseModel = expenses;
      case Left():
        showError('Houver erro ao buscar a conta $type');
    }

    return expenseModel;
  }

  List<ExpenseModel> findExpenseDate(String date) {
    List<ExpenseModel> expenses = _data
        .where((expense) =>
            (expense.date.toLowerCase().contains(date.toLowerCase())))
        .toList();
    valueWorkshopExpense.value = _sumValueExpense(expenses);
    return expenses;
  }

  double _sumValueExpense(List<ExpenseModel> expenses) {
    double valueExpense = 0;
    for (var expense in expenses) {
      valueExpense += expense.value;
    }

    return valueExpense;
  }

  void addData(ExpenseModel expense) {
    _data.add(expense);
  }

  void updateData(ExpenseModel expense, String? dateOfLastPurchase) {
    _data.removeWhere((data) =>
        data.materialId == expense.materialId &&
        data.date == dateOfLastPurchase);

    _data.add(expense);
  }
}
