// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_items_budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MateriaItemsBudgetModel _$MateriaItemsBudgetModelFromJson(
        Map<String, dynamic> json) =>
    MateriaItemsBudgetModel(
      id: json['id'] as int? ?? 0,
      value: (json['value'] as num).toDouble(),
      materialId: json['material_id'] as int,
      budgetId: json['budget_id'] as int,
    );

Map<String, dynamic> _$MateriaItemsBudgetModelToJson(
        MateriaItemsBudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'material_id': instance.materialId,
      'budget_id': instance.budgetId,
    };
