// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workshop_expense_items_budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkshopExpenseItemsBudgetModel _$WorkshopExpenseItemsBudgetModelFromJson(
        Map<String, dynamic> json) =>
    WorkshopExpenseItemsBudgetModel(
      id: json['id'] as int? ?? 0,
      value: (json['value'] as num?)?.toDouble() ?? 0,
      dividedValue: (json['divided_value'] as num?)?.toDouble() ?? 0,
      accumulatedValue: (json['accumulated_value'] as num?)?.toDouble() ?? 0,
      type: json['type'] as String,
      itemBudgetId: json['item_budget_id'] as int?,
    );

Map<String, dynamic> _$WorkshopExpenseItemsBudgetModelToJson(
        WorkshopExpenseItemsBudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'divided_value': instance.dividedValue,
      'accumulated_value': instance.accumulatedValue,
      'type': instance.type,
      'item_budget_id': instance.itemBudgetId,
    };
