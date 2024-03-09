// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalExpenseModel _$PersonalExpenseModelFromJson(
        Map<String, dynamic> json) =>
    PersonalExpenseModel(
      id: json['id'] as int? ?? 0,
      type: json['type'] as String,
      value: (json['value'] as num).toDouble(),
      date: json['date'] as String,
      methodPayment: json['method_payment'] as String,
      observation: json['observation'] as String?,
    );

Map<String, dynamic> _$PersonalExpenseModelToJson(
        PersonalExpenseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'value': instance.value,
      'date': instance.date,
      'method_payment': instance.methodPayment,
      'observation': instance.observation,
    };
