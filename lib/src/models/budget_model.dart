// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:js_budget/src/models/fixed_expense_items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';

part 'budget_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BudgetModel {
  int id;
  double? valueTotal;
  String? status;
  List<MaterialItemsBudgetModel>? materialItemsBudget;
  List<FixedExpenseItemsBudgetModel>? fixedExpenseItemsBudget;
  List<ProductModel> products;
  List<ServiceModel> services;
  String? createdAt;
  int? clientId;
  int? orderId;

  BudgetModel({
    this.id = 0,
    this.valueTotal,
    this.status,
    this.materialItemsBudget,
    this.fixedExpenseItemsBudget,
    required this.products,
    required this.services,
    this.createdAt,
    this.clientId,
    this.orderId,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetModelToJson(this);
}
