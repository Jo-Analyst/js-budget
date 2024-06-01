// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'payment_history_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentHistoryModel {
  final int id;
  final String specie;
  double amountPaid;
  final String datePayment;
  final int paymentId;
  PaymentHistoryModel({
    required this.id,
    required this.specie,
    required this.amountPaid,
    required this.datePayment,
    required this.paymentId,
  });

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentHistoryModelToJson(this);
}
