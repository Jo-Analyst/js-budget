import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentModel {
  final String specie;
  final double amountPaid;
  String? datePayment;
  final int numberOfInstallments;
  int? budgetId;

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  PaymentModel({
    required this.specie,
    required this.amountPaid,
    this.datePayment,
    this.numberOfInstallments = 1,
    this.budgetId,
  });

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
