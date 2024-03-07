// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'material_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MaterialModel {
  final int id;
  final String name;
  final String? type;
  final String unit;
  final double price;
  final int quantity;
  final String? observation;
  final String? dateOfLastPurchase;
  final String? supplier;

  MaterialModel({
    this.id = 0,
    required this.name,
    this.type,
    required this.unit,
    required this.price,
    required this.quantity,
    this.observation,
    this.dateOfLastPurchase,
    this.supplier,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialModelToJson(this);
}
