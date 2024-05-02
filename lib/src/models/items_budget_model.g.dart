// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsBudgetModel _$ItemsBudgetModelFromJson(Map<String, dynamic> json) =>
    ItemsBudgetModel(
      id: json['id'] as int? ?? 0,
      value: (json['value'] as num?)?.toDouble() ?? 0,
      term: json['term'] as int? ?? 1,
      timeIncentive: json['timeIncentive'] as String? ?? 'Dia',
      materialItemsBudget: (json['materialItemsBudget'] as List<dynamic>)
          .map((e) =>
              MaterialItemsBudgetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      fixedExpenseItemsBudget: (json['fixedExpenseItemsBudget']
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
      budgetId: json['budgetId'] as int?,
    );

Map<String, dynamic> _$ItemsBudgetModelToJson(ItemsBudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'term': instance.term,
      'timeIncentive': instance.timeIncentive,
      'materialItemsBudget': instance.materialItemsBudget,
      'fixedExpenseItemsBudget': instance.fixedExpenseItemsBudget,
      'product': instance.product,
      'service': instance.service,
      'budgetId': instance.budgetId,
    };
