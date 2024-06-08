import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/modules/expenses/personal_expenses/personal_expense_form/personal_expense_form_page.dart';

mixin PersonalExpenseFormController on State<PersonalExpenseFormPage> {
  final typeOfExpenseEC = TextEditingController();
  final expenseValueEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final expenseDateEC = TextEditingController();
  final observationEC = TextEditingController();

  void disposeForm() {
    typeOfExpenseEC.dispose();
    expenseValueEC.dispose();
    expenseDateEC.dispose();
    observationEC.dispose();
  }

  initializeForm(ExpenseModel expense) {
    typeOfExpenseEC.text = expense.description;
    expenseValueEC.updateValue(expense.value);
    expenseDateEC.text = expense.date;
    observationEC.text = expense.observation ?? '';
  }

  ExpenseModel saveExpense(int id, String methodPayment) {
    return ExpenseModel(
      id: id,
      description: typeOfExpenseEC.text.trim(),
      value: expenseValueEC.numberValue,
      date: expenseDateEC.text.trim(),
      methodPayment: methodPayment,
      observation: observationEC.text.trim(),
    );
  }
}
