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
      material:
          MaterialModel.fromJson(json['material'] as Map<String, dynamic>),
      itemBudgetId: json['itemBudgetId'] as int?,
    );

Map<String, dynamic> _$MaterialItemsBudgetModelToJson(
        MaterialItemsBudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'quantity': instance.quantity,
      'material': instance.material,
      'itemBudgetId': instance.itemBudgetId,
    };
