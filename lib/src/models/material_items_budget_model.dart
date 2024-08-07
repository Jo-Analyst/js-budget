// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:js_budget/src/models/material_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'material_items_budget_model.g.dart';

@JsonSerializable()
class MaterialItemsBudgetModel {
  final int id;
  double value;
  int quantity;
  MaterialModel material;
  final int? itemBudgetId;
  MaterialItemsBudgetModel({
    this.id = 0,
    this.value = 0,
    this.quantity = 1,
    required this.material,
    this.itemBudgetId,
  });

  factory MaterialItemsBudgetModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialItemsBudgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialItemsBudgetModelToJson(this);
}
