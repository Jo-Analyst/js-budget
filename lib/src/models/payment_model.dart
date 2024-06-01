import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentModel {
  final int id;
  final String specie;
  double amountPaid;
  final double amountToPay;
  final int numberOfInstallments;
  int? budgetId;

  PaymentModel({
    this.id = 0,
    required this.specie,
    this.amountPaid = 0.0,
    required this.amountToPay,
    this.numberOfInstallments = 1,
    this.budgetId,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
