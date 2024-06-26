// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      id: json['id'] as int? ?? 0,
      specie: json['specie'] as String,
      amountPaid: (json['amount_paid'] as num?)?.toDouble() ?? 0.0,
      amountToPay: (json['amount_to_pay'] as num).toDouble(),
      numberOfInstallments: json['number_of_installments'] as int? ?? 1,
      budgetId: json['budget_id'] as int?,
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'specie': instance.specie,
      'amount_paid': instance.amountPaid,
      'amount_to_pay': instance.amountToPay,
      'number_of_installments': instance.numberOfInstallments,
      'budget_id': instance.budgetId,
    };
