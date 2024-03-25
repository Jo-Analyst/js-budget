import 'package:js_budget/src/models/fixed_expense_model.dart';

class TransformJson {
  static Map<String, dynamic> toJson(FixedExpenseModel personal) {
    return {
      'id': personal.id,
      'type': personal.type,
      'value': personal.value,
      'method_payment': personal.methodPayment,
      'date': personal.date,
      'observation': personal.observation
    };
  }

  static FixedExpenseModel fromJson(Map<String, dynamic> personal) {
    return FixedExpenseModel(
      id: personal['id'] as int,
      type: personal['type'],
      value: personal['value'] as double,
      methodPayment: personal['method_payment'],
      date: personal['date'],
      observation: personal['observation'],
    );
  }
}
