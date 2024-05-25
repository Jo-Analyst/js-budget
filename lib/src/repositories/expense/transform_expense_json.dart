import 'package:js_budget/src/models/expense_model.dart';

class TransformExpenseJson {
  static Map<String, dynamic> toJson(ExpenseModel expense) {
    return {
      'id': expense.id,
      'type': expense.type,
      'value': expense.value,
      'method_payment': expense.methodPayment,
      'date': expense.date,
      'observation': expense.observation
    };
  }

  static ExpenseModel fromJson(Map<String, dynamic> expense) {
    return ExpenseModel(
      id: expense['id'] as int,
      type: expense['type'],
      value: expense['value'] as double,
      methodPayment: expense['method_payment'],
      date: expense['date'],
      observation: expense['observation'],
    );
  }
}
