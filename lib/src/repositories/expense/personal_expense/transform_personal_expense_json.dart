import 'package:js_budget/src/models/expense_model.dart';

class TransformPersonalExpenseJson {
  static Map<String, dynamic> toJson(ExpenseModel personalExpense) {
    return {
      'id': personalExpense.id,
      'type': personalExpense.type,
      'value': personalExpense.value,
      'method_payment': personalExpense.methodPayment,
      'date': personalExpense.date,
      'observation': personalExpense.observation
    };
  }

  static ExpenseModel fromJson(Map<String, dynamic> personalExpense) {
    return ExpenseModel(
      id: personalExpense['id'] as int,
      type: personalExpense['type'],
      value: personalExpense['value'] as double,
      methodPayment: personalExpense['method_payment'],
      date: personalExpense['date'],
      observation: personalExpense['observation'],
    );
  }
}
