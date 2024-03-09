// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixed_expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FixedExpenseModel _$FixedExpenseModelFromJson(Map<String, dynamic> json) =>
    FixedExpenseModel(
      id: json['id'] as int? ?? 0,
      type: json['type'] as String,
      value: (json['value'] as num).toDouble(),
      date: json['date'] as String,
      methodPayment: json['methodPayment'] as String,
      observation: json['observation'] as String?,
    );

Map<String, dynamic> _$FixedExpenseModelToJson(FixedExpenseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'value': instance.value,
      'date': instance.date,
      'methodPayment': instance.methodPayment,
      'observation': instance.observation,
    };
