// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetModel _$BudgetModelFromJson(Map<String, dynamic> json) => BudgetModel(
      json['id'] as int? ?? 0,
      (json['value_total'] as num).toDouble(),
      json['created_at'] as String,
      json['client_id'] as int,
    );

Map<String, dynamic> _$BudgetModelToJson(BudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value_total': instance.valueTotal,
      'created_at': instance.createdAt,
      'client_id': instance.clientId,
    };
