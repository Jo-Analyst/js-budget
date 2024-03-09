// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'fixed_expense_model.g.dart';

@JsonSerializable()
class FixedExpenseModel {
  final int id;
  final String type;
  final double value;
  final String date;
  final String methodPayment;
  final String? observation;
  FixedExpenseModel({
    this.id = 0,
    required this.type,
    required this.value,
    required this.date,
    required this.methodPayment,
    this.observation,
  });

  factory FixedExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$FixedExpenseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FixedExpenseModelToJson(this);
}
