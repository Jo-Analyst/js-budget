// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_items_budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialItemsBudgetModel _$MaterialItemsBudgetModelFromJson(
        Map<String, dynamic> json) =>
    MaterialItemsBudgetModel(
      id: json['id'] as int? ?? 0,
      value: (json['value'] as num).toDouble(),
      quantity: json['quantity'] as int? ?? 1,
      materialId: json['materialId'] as int,
      budgetId: json['budgetId'] as int,
    );

Map<String, dynamic> _$MaterialItemsBudgetModelToJson(
        MaterialItemsBudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'quantity': instance.quantity,
      'materialId': instance.materialId,
      'budgetId': instance.budgetId,
    };
