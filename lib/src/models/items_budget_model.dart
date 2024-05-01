import 'package:json_annotation/json_annotation.dart';

import 'package:js_budget/src/models/fixed_expense_items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';

part 'items_budget_model.g.dart';

@JsonSerializable()
class ItemsBudgetModel {
  int id;
  double value;
  List<MaterialItemsBudgetModel> materialItemsBudget;
  List<FixedExpenseItemsBudgetModel> fixedExpenseItemsBudget;
  ProductModel? product;
  ServiceModel? service;
  int? budgetId;
  ItemsBudgetModel({
    this.id = 0,
    this.value = 0,
    required this.materialItemsBudget,
    required this.fixedExpenseItemsBudget,
    this.product,
    this.service,
    this.budgetId,
  });

  factory ItemsBudgetModel.fromJson(Map<String, dynamic> json) =>
      _$ItemsBudgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsBudgetModelToJson(this);
}
