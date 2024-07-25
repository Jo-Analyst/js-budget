// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/items_budget_model.dart';
import 'package:js_budget/src/models/payment_model.dart';

part 'budget_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BudgetModel {
  int id;
  double? amount;
  String? status;
  double? freight;
  double discount;
  PaymentModel? payment;
  List<ItemsBudgetModel>? itemsBudget;
  String? createdAt;
  String? approvalDate;
  ClientModel? client;
  int? orderId;

  BudgetModel({
    this.id = 0,
    this.discount = 0.0,
    this.amount,
    this.status,
    this.freight,
    this.payment,
    this.itemsBudget,
    this.createdAt,
    this.approvalDate,
    this.client,
    this.orderId,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetModelToJson(this);
}
