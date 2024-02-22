// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetItemsModel _$BudgetItemsModelFromJson(Map<String, dynamic> json) =>
    BudgetItemsModel(
      id: json['id'] as int? ?? 0,
      value: (json['value'] as num).toDouble(),
      budgetId: json['budget_id'] as int,
    );

Map<String, dynamic> _$BudgetItemsModelToJson(BudgetItemsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'budget_id': instance.budgetId,
    };
