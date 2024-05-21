import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentModel {
  final int id;
  final String specie;
  final double amountPaid;
  String datePayment;
  final int numberOfInstallments;
  final int budgetId;

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  PaymentModel({
    this.id = 0,
    required this.specie,
    required this.amountPaid,
    required this.datePayment,
    this.numberOfInstallments = 1,
    required this.budgetId,
  });

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
