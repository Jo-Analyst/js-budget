// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsBudgetModel _$ItemsBudgetModelFromJson(Map<String, dynamic> json) =>
    ItemsBudgetModel(
      id: json['id'] as int? ?? 0,
      subValue: (json['sub_value'] as num?)?.toDouble() ?? 0,
      unitaryValue: (json['unitary_value'] as num?)?.toDouble() ?? 0,
      term: json['term'] as int? ?? 1,
      timeIncentive: json['time_incentive'] as String? ?? 'Dia',
      percentageProfitMargin:
          (json['percentage_profit_margin'] as num?)?.toDouble() ?? 0.0,
      profitMargin: (json['profit_margin'] as num?)?.toDouble() ?? 0.0,
      materialItemsBudget: (json['material_items_budget'] as List<dynamic>)
          .map((e) =>
              MaterialItemsBudgetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      fixedExpenseItemsBudget: (json['fixed_expense_items_budget']
              as List<dynamic>)
          .map((e) =>
              FixedExpenseItemsBudgetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      product: json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      service: json['service'] == null
          ? null
          : ServiceModel.fromJson(json['service'] as Map<String, dynamic>),
      budgetId: json['budget_id'] as int?,
    );

Map<String, dynamic> _$ItemsBudgetModelToJson(ItemsBudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sub_value': instance.subValue,
      'unitary_value': instance.unitaryValue,
      'term': instance.term,
      'time_incentive': instance.timeIncentive,
      'percentage_profit_margin': instance.percentageProfitMargin,
      'profit_margin': instance.profitMargin,
      'material_items_budget': instance.materialItemsBudget,
      'fixed_expense_items_budget': instance.fixedExpenseItemsBudget,
      'product': instance.product,
      'service': instance.service,
      'budget_id': instance.budgetId,
    };
