// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetModel _$BudgetModelFromJson(Map<String, dynamic> json) => BudgetModel(
      id: json['id'] as int? ?? 0,
      valueTotal: (json['value_total'] as num?)?.toDouble(),
      status: json['status'] as String?,
      itemsBudget: (json['items_budget'] as List<dynamic>?)
          ?.map((e) => ItemsBudgetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
      clientId: json['client_id'] as int?,
      orderId: json['order_id'] as int?,
    );

Map<String, dynamic> _$BudgetModelToJson(BudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value_total': instance.valueTotal,
      'status': instance.status,
      'items_budget': instance.itemsBudget,
      'created_at': instance.createdAt,
      'client_id': instance.clientId,
      'order_id': instance.orderId,
    };
