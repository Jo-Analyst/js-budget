// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) => ExpenseModel(
      id: json['id'] as int? ?? 0,
      type: json['type'] as String,
      value: json['value'] as String,
      date: json['date'] as String,
      methodPayment: json['method_payment'] as String,
      observation: json['observation'] as String,
    );

Map<String, dynamic> _$ExpenseModelToJson(ExpenseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'value': instance.value,
      'date': instance.date,
      'method_payment': instance.methodPayment,
      'observation': instance.observation,
    };
