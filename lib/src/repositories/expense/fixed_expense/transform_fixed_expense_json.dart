import 'package:js_budget/src/models/expense_model.dart';

class TransformFixedExpenseJson {
  static Map<String, dynamic> toJson(ExpenseModel personal) {
    return {
      'id': personal.id,
      'type': personal.type,
      'value': personal.value,
      'method_payment': personal.methodPayment,
      'date': personal.date,
      'observation': personal.observation
    };
  }

  static ExpenseModel fromJson(Map<String, dynamic> personal) {
    return ExpenseModel(
      id: personal['id'] as int,
      type: personal['type'],
      value: personal['value'] as double,
      methodPayment: personal['method_payment'],
      date: personal['date'],
      observation: personal['observation'],
    );
  }
}
