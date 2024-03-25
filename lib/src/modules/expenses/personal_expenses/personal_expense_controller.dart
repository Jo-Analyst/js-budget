import 'package:signals/signals.dart';

import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/personal_expense_model.dart';
import 'package:js_budget/src/modules/expenses/personal_expenses/transform_personal_expense_json.dart';
import 'package:js_budget/src/repositories/personal_expense/personal_repository.dart';

class PersonalExpenseController with Messages {
  final _data = ListSignal<PersonalExpenseModel>([]);
  ListSignal get data => _data
    ..sort(
      (a, b) => a.type
          .toString()
          .toLowerCase()
          .compareTo(b.type.toString().toLowerCase()),
    );

  final model = signal<PersonalExpenseModel?>(null);

  final PersonalExpenseRepository _personalExpenseRepository;
  PersonalExpenseController({
    required PersonalExpenseRepository personalExpenseRepository,
  }) : _personalExpenseRepository = personalExpenseRepository;

  Future<void> save(PersonalExpenseModel personalExpense) async {
    final result = personalExpense.id == 0
        ? await _personalExpenseRepository.register(personalExpense)
        : await _personalExpenseRepository.update(personalExpense);

    switch (result) {
      case Right(value: PersonalExpenseModel model):
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

  Future<void> deleteMaterial(int id) async {
    final result = await _personalExpenseRepository.delete(id);
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
    final results = await _personalExpenseRepository.findAll();

    switch (results) {
      case Right(value: List<Map<String, dynamic>> personalExpenses):
        for (var personalExpense in personalExpenses) {
          _data.add(TransformJson.fromJson(personalExpense));
        }

      case Left():
        showError('Houver erro ao buscar o despesa');
    }
  }
}
