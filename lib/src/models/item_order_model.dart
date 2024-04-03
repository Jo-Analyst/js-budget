// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_order_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemOrderModel {
  final int id;
  final List<ProductModel>? products;
  final List<ServiceModel>? services;
  ItemOrderModel({
    this.id = 0,
    this.products,
    this.services,
  });

  factory ItemOrderModel.fromJson(Map<String, dynamic> json) =>
      _$ItemOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemOrderModelToJson(this);
}