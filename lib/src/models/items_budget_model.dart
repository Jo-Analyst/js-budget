import 'package:json_annotation/json_annotation.dart';

import 'package:js_budget/src/models/workshop_expense_items_budget_model.dart';
import 'package:js_budget/src/models/material_items_budget_model.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';

part 'items_budget_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemsBudgetModel {
  int id;
  double subValue;
  double unitaryValue;
  int quantity;
  int term;
  double subDiscount;
  String timeIncentive;
  double percentageProfitMargin;
  double profitMarginValue;
  List<MaterialItemsBudgetModel> materialItemsBudget;
  List<WorkshopExpenseItemsBudgetModel> workshopExpenseItemsBudget;
  ProductModel? product;
  ServiceModel? service;
  int? budgetId;
  ItemsBudgetModel({
    this.id = 0,
    this.subValue = 0,
    this.subDiscount = 0.0,
    this.unitaryValue = 0,
    required this.quantity,
    this.term = 0,
    this.timeIncentive = 'Dia',
    this.percentageProfitMargin = 0.0,
    this.profitMarginValue = 0.0,
    required this.materialItemsBudget,
    required this.workshopExpenseItemsBudget,
    this.product,
    this.service,
    this.budgetId,
  });

  factory ItemsBudgetModel.fromJson(Map<String, dynamic> json) =>
      _$ItemsBudgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsBudgetModelToJson(this);
}
