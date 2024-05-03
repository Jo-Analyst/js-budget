// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'fixed_expense_items_budget_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FixedExpenseItemsBudgetModel {
  @JsonKey(defaultValue: 0)
  final int id;
  double value;
  double dividedValue;
  double accumulatedValue;
  final String type;
  final int? itemBudgetId;

  FixedExpenseItemsBudgetModel({
    this.id = 0,
    this.value = 0,
    this.dividedValue = 0,
    this.accumulatedValue = 0,
    required this.type,
    this.itemBudgetId,
  });

  factory FixedExpenseItemsBudgetModel.fromJson(Map<String, dynamic> json) =>
      _$FixedExpenseItemsBudgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$FixedExpenseItemsBudgetModelToJson(this);
}
