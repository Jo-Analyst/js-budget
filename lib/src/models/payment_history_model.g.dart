// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentHistoryModel _$PaymentHistoryModelFromJson(Map<String, dynamic> json) =>
    PaymentHistoryModel(
      id: json['id'] as int,
      specie: json['specie'] as String,
      amountPaid: (json['amount_paid'] as num).toDouble(),
      datePayment: json['date_payment'] as String,
      paymentId: json['payment_id'] as int,
    );

Map<String, dynamic> _$PaymentHistoryModelToJson(
        PaymentHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'specie': instance.specie,
      'amount_paid': instance.amountPaid,
      'date_payment': instance.datePayment,
      'payment_id': instance.paymentId,
    };
