// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'budget_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BudgetModel {
  @JsonKey(defaultValue: 0)
  final int id;
  final double valueTotal;
  final String status;
  final String createdAt;
  final int clientId;

  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetModelFromJson(json);

  BudgetModel(
    this.id,
    this.valueTotal,
    this.status,
    this.createdAt,
    this.clientId,
  );

  Map<String, dynamic> toJson() => _$BudgetModelToJson(this);
}
