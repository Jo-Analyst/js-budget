// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetModel _$BudgetModelFromJson(Map<String, dynamic> json) => BudgetModel(
      id: json['id'] as int? ?? 0,
      valueTotal: (json['value_total'] as num?)?.toDouble(),
      status: json['status'] as String?,
      paymentMethod: json['payment_method'] as String?,
      itemsBudget: (json['items_budget'] as List<dynamic>?)
          ?.map((e) => ItemsBudgetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
      client: json['client'] == null
          ? null
          : ClientModel.fromJson(json['client'] as Map<String, dynamic>),
      orderId: json['order_id'] as int?,
    );

Map<String, dynamic> _$BudgetModelToJson(BudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value_total': instance.valueTotal,
      'status': instance.status,
      'payment_method': instance.paymentMethod,
      'items_budget': instance.itemsBudget,
      'created_at': instance.createdAt,
      'client': instance.client,
      'order_id': instance.orderId,
    };
