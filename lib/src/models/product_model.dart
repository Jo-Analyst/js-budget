// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductModel {
  final int id;
  final String name;
  int quantity;
  final String description;
  final String unit;
  ProductModel({
    this.id = 0,
    required this.name,
    this.quantity = 1,
    required this.description,
    required this.unit,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
