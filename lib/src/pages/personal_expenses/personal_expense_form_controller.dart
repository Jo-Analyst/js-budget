import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:js_budget/src/pages/personal_expenses/personal_expense_form_page.dart';

mixin PersonalExpenseFormController on State<PersonalExpenseFormPage> {
  final typeOfExpenseEC = TextEditingController();
  final expenseValueEC = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final expenseDateEC = TextEditingController();
  final observationEC = TextEditingController();
  final methodPaymentEC = TextEditingController();

  void disposeForm() {
    typeOfExpenseEC.dispose();
    expenseValueEC.dispose();
    expenseDateEC.dispose();
    observationEC.dispose();
    methodPaymentEC.dispose();
  }
}
