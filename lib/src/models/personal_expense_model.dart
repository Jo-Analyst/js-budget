// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'personal_expense_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ExpenseModel {
  final int id;
  final String type;
  final String value;
  final String date;
  final String methodPayment;
  final String observation;
  ExpenseModel({
    this.id = 0,
    required this.type,
    required this.value,
    required this.date,
    required this.methodPayment,
    required this.observation,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseModelToJson(this);
}
