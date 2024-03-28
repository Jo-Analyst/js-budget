import 'package:json_annotation/json_annotation.dart';

part 'products_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductsModel {
  final int id;
  final String name;
  final String detail;
  final String unit;
  ProductsModel({
    this.id = 0,
    required this.name,
    required this.detail,
    required this.unit,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);
}
