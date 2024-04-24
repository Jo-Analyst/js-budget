import 'package:json_annotation/json_annotation.dart';

part 'fixed_expense_items_budget_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FixedExpenseItemsBudgetModel {
  @JsonKey(defaultValue: 0)
  final int id;
  double value;
  final String type;
  final int? budgetId;

  FixedExpenseItemsBudgetModel({
    this.id = 0,
    required this.value,
    required this.type,
    this.budgetId,
  });

  factory FixedExpenseItemsBudgetModel.fromJson(Map<String, dynamic> json) =>
      _$FixedExpenseItemsBudgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$FixedExpenseItemsBudgetModelToJson(this);
}
