import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/modules/expenses/fixed_expenses/fixed_expense_form/fixed_expense_form_page.dart';

mixin FixedExpenseFormController on State<FixedExpenseFormPage> {
  final expenseValueEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final expenseDateEC = TextEditingController();
  final observationEC = TextEditingController();
  final otherEC = TextEditingController();

  void disposeForm() {
    expenseValueEC.dispose();
    expenseDateEC.dispose();
    observationEC.dispose();
    otherEC.dispose();
  }

  initializeForm(ExpenseModel expense) {
    otherEC.text = expense.type;
    expenseValueEC.updateValue(expense.value);
    expenseDateEC.text = expense.date;
    observationEC.text = expense.observation ?? '';
  }

  ExpenseModel saveExpense(int id, String methodPayment, String type) {
    return ExpenseModel(
      id: id,
      type:  type,
      value: expenseValueEC.numberValue,
      date: expenseDateEC.text.trim(),
      methodPayment: methodPayment,
      observation: observationEC.text.trim(),
    );
  }
}
