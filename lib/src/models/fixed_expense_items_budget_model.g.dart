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
      description: json['description'] as String,
      quantity: json['quantity'] as int? ?? 1,
      budgetId: json['budget_id'] as int,
    );

Map<String, dynamic> _$FixedExpenseItemsBudgetModelToJson(
        FixedExpenseItemsBudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'description': instance.description,
      'quantity': instance.quantity,
      'budget_id': instance.budgetId,
    };
