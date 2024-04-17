// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'material_items_budget_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MateriaItemsBudgetModel {
  @JsonKey(defaultValue: 0)
  final int id;
  final double value;
  final int materialId;
  final int budgetId;
  MateriaItemsBudgetModel({
    required this.id,
    required this.value,
    required this.materialId,
    required this.budgetId,
  });

  factory MateriaItemsBudgetModel.fromJson(Map<String, dynamic> json) =>
      _$MateriaItemsBudgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$MateriaItemsBudgetModelToJson(this);
}
