// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'fixed_expense_items_budget_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FixedExpenseItemsBudgetModel {
  @JsonKey(defaultValue: 0)
  final int id;
  final double value;
  final int fixedExpenseId;
  final int budgetId;
  FixedExpenseItemsBudgetModel({
    required this.id,
    required this.value,
    required this.fixedExpenseId,
    required this.budgetId,
  });

  factory FixedExpenseItemsBudgetModel.fromJson(Map<String, dynamic> json) =>
      _$FixedExpenseItemsBudgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$FixedExpenseItemsBudgetModelToJson(this);
}
