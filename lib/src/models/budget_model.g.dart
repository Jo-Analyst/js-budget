// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetModel _$BudgetModelFromJson(Map<String, dynamic> json) => BudgetModel(
      id: json['id'] as int? ?? 0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      amount: (json['amount'] as num?)?.toDouble(),
      status: json['status'] as String?,
      freight: (json['freight'] as num?)?.toDouble(),
      payment: json['payment'] == null
          ? null
          : PaymentModel.fromJson(json['payment'] as Map<String, dynamic>),
      itemsBudget: (json['items_budget'] as List<dynamic>?)
          ?.map((e) => ItemsBudgetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
      approvalDate: json['approval_date'] as String?,
      client: json['client'] == null
          ? null
          : ClientModel.fromJson(json['client'] as Map<String, dynamic>),
      orderId: json['order_id'] as int?,
    );

Map<String, dynamic> _$BudgetModelToJson(BudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'status': instance.status,
      'freight': instance.freight,
      'discount': instance.discount,
      'payment': instance.payment,
      'items_budget': instance.itemsBudget,
      'created_at': instance.createdAt,
      'approval_date': instance.approvalDate,
      'client': instance.client,
      'order_id': instance.orderId,
    };
