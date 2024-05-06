// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:js_budget/src/models/fixed_expense_items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';

part 'items_budget_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemsBudgetModel {
  int id;
  double subValue;
  double unitaryValue;
  int term;
  String timeIncentive;
  double percentageProfitMargin;
  double valueProfitMargin;
  List<MaterialItemsBudgetModel> materialItemsBudget;
  List<FixedExpenseItemsBudgetModel> fixedExpenseItemsBudget;
  ProductModel? product;
  ServiceModel? service;
  int? budgetId;
  ItemsBudgetModel({
    this.id = 0,
    this.subValue = 0,
    this.unitaryValue = 0,
    this.term = 1,
    this.timeIncentive = 'Dia',
    this.percentageProfitMargin = 0.0,
    this.valueProfitMargin = 0.0,
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
