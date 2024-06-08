// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'expense_model.g.dart';

@JsonSerializable()
class ExpenseModel {
  final int id;
  final String description;
  final double value;
  final String date;
  final String methodPayment;
  final String? observation;
  final int? materialId;
  ExpenseModel({
    this.id = 0,
    required this.description,
    required this.value,
    required this.date,
    required this.methodPayment,
    this.observation,
    this.materialId,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseModelToJson(this);
}
