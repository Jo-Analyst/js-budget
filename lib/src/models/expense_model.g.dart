// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) => ExpenseModel(
      id: json['id'] as int? ?? 0,
      type: json['type'] as String,
      value: (json['value'] as num).toDouble(),
      date: json['date'] as String,
      methodPayment: json['methodPayment'] as String,
      observation: json['observation'] as String?,
    );

Map<String, dynamic> _$ExpenseModelToJson(ExpenseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'value': instance.value,
      'date': instance.date,
      'methodPayment': instance.methodPayment,
      'observation': instance.observation,
    };
