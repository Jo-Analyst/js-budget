// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';

part 'budget_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BudgetModel {
  int id;
  double? valueTotal;
  String? status;
  String? paymentMethod;
  List<ItemsBudgetModel>? itemsBudget;

  String? createdAt;
  ClientModel? client;
  int? orderId;

  BudgetModel({
    this.id = 0,
    this.valueTotal,
    this.status,
    this.paymentMethod,
    this.itemsBudget,
    this.createdAt,
    this.client,
    this.orderId,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetModelToJson(this);
}
