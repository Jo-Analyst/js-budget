// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixed_expense_items_budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FixedExpenseItemsBudgetModel _$FixedExpenseItemsBudgetModelFromJson(
        Map<String, dynamic> json) =>
    FixedExpenseItemsBudgetModel(
      id: json['id'] as int? ?? 0,
      value: (json['value'] as num).toDouble(),
      dividedValue: (json['divided_value'] as num).toDouble(),
      accumulatedValue: (json['accumulated_value'] as num).toDouble(),
      type: json['type'] as String,
      budgetId: json['budget_id'] as int?,
    );

Map<String, dynamic> _$FixedExpenseItemsBudgetModelToJson(
        FixedExpenseItemsBudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'divided_value': instance.dividedValue,
      'accumulated_value': instance.accumulatedValue,
      'type': instance.type,
      'budget_id': instance.budgetId,
    };
