// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'personal_expense_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PersonalExpenseModel {
  final int id;
  final String type;
  final double value;
  final String date;
  final String methodPayment;
  final String? observation;
  PersonalExpenseModel({
    this.id = 0,
    required this.type,
    required this.value,
    required this.date,
    required this.methodPayment,
    this.observation,
  });

  factory PersonalExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalExpenseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalExpenseModelToJson(this);
}
