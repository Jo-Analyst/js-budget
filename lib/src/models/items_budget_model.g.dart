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
      quantity: json['quantity'] as int,
      term: json['term'] as int? ?? 1,
      timeIncentive: json['time_incentive'] as String? ?? 'Dia',
      percentageProfitMargin:
          (json['percentage_profit_margin'] as num?)?.toDouble() ?? 0.0,
      profitMarginValue:
          (json['profit_margin_value'] as num?)?.toDouble() ?? 0.0,
      materialItemsBudget: (json['material_items_budget'] as List<dynamic>)
          .map((e) =>
              MaterialItemsBudgetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      workshopExpenseItemsBudget:
          (json['workshop_expense_items_budget'] as List<dynamic>)
              .map((e) => WorkshopExpenseItemsBudgetModel.fromJson(
                  e as Map<String, dynamic>))
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
      'quantity': instance.quantity,
      'term': instance.term,
      'time_incentive': instance.timeIncentive,
      'percentage_profit_margin': instance.percentageProfitMargin,
      'profit_margin_value': instance.profitMarginValue,
      'material_items_budget': instance.materialItemsBudget,
      'workshop_expense_items_budget': instance.workshopExpenseItemsBudget,
      'product': instance.product,
      'service': instance.service,
      'budget_id': instance.budgetId,
    };
