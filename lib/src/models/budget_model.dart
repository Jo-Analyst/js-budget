// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:js_budget/src/models/fixed_expense_items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';

part 'budget_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BudgetModel {
  final int id;
  final double valueTotal;
  final String status;
  final List<MaterialItemsBudgetModel>? materialItemsBudget;
  final List<FixedExpenseItemsBudgetModel>? fixedExpenseItemsBudget;
  final String createdAt;
  final int clientId;
  final int orderId;

  BudgetModel({
    this.id = 0,
    required this.valueTotal,
    required this.status,
    this.materialItemsBudget,
    this.fixedExpenseItemsBudget,
    required this.createdAt,
    required this.clientId,
    required this.orderId,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetModelToJson(this);
}
