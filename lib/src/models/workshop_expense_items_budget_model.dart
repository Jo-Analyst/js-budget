// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'workshop_expense_items_budget_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WorkshopExpenseItemsBudgetModel {
  @JsonKey(defaultValue: 0)
  final int id;
  double value;
  double dividedValue;
  double accumulatedValue;
  final String type;
  final int? itemBudgetId;

  WorkshopExpenseItemsBudgetModel({
    this.id = 0,
    this.value = 0,
    this.dividedValue = 0,
    this.accumulatedValue = 0,
    required this.type,
    this.itemBudgetId,
  });

  factory WorkshopExpenseItemsBudgetModel.fromJson(Map<String, dynamic> json) =>
      _$WorkshopExpenseItemsBudgetModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$WorkshopExpenseItemsBudgetModelToJson(this);
}
