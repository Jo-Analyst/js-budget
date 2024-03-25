import 'package:js_budget/src/models/personal_expense_model.dart';

class TransformJson {
  static Map<String, dynamic> toJson(PersonalExpenseModel personalExpense) {
    return {
      'id': personalExpense.id,
      'type': personalExpense.type,
      'value': personalExpense.value,
      'method_payment': personalExpense.methodPayment,
      'date': personalExpense.date,
      'observation': personalExpense.observation
    };
  }

  static PersonalExpenseModel fromJson(Map<String, dynamic> personalExpense) {
    return PersonalExpenseModel(
      id: personalExpense['id'] as int,
      type: personalExpense['type'],
      value: personalExpense['value'] as double,
      methodPayment: personalExpense['method_payment'],
      date: personalExpense['date'],
      observation: personalExpense['observation'],
    );
  }
}
