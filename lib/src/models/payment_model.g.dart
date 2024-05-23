// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      specie: json['specie'] as String,
      amountPaid: (json['amount_paid'] as num?)?.toDouble() ?? 0.0,
      amountToPay: (json['amount_to_pay'] as num).toDouble(),
      datePayment: json['date_payment'] as String?,
      numberOfInstallments: json['number_of_installments'] as int? ?? 1,
      budgetId: json['budget_id'] as int?,
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'specie': instance.specie,
      'amount_paid': instance.amountPaid,
      'amount_to_pay': instance.amountToPay,
      'date_payment': instance.datePayment,
      'number_of_installments': instance.numberOfInstallments,
      'budget_id': instance.budgetId,
    };
