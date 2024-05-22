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
    this.amountPaid = 0.0,
    this.datePayment,
    this.numberOfInstallments = 1,
    this.budgetId,
  });

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
