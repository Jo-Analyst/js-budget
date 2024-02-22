// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'budget_items_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BudgetItemsModel {
  @JsonKey(defaultValue: 0)
  final int id;
  final double value;
  final int budgetId;
  BudgetItemsModel({
    required this.id,
    required this.value,
    required this.budgetId,
  });

  factory BudgetItemsModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetItemsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetItemsModelToJson(this);
}
