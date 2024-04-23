// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'material_items_budget_model.g.dart';

@JsonSerializable()
class MaterialItemsBudgetModel {
  final int id;
  double value;
  int quantity;
  final int materialId;
  final int budgetId;
  MaterialItemsBudgetModel({
    this.id = 0,
    required this.value,
    this.quantity = 1,
    required this.materialId,
    required this.budgetId,
  });

  factory MaterialItemsBudgetModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialItemsBudgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialItemsBudgetModelToJson(this);
}
