import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/pages/fixed_expenses/fixed_expense_form_page.dart';

mixin FixedExpenseFormController on State<FixedExpenseFormPage> {
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
}
