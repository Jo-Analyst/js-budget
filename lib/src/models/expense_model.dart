import 'package:json_annotation/json_annotation.dart';

part 'expense_model.g.dart';

@JsonSerializable()
class ExpenseModel {
  final int id;
  final String type;
  final double value;
  final String date;
  final String methodPayment;
  final String? observation;
  ExpenseModel({
    this.id = 0,
    required this.type,
    required this.value,
    required this.date,
    required this.methodPayment,
    this.observation,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseModelToJson(this);
}
