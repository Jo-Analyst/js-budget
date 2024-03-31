// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/models/service_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_request_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemRequestModel {
  final int id;
  final List<ProductModel>? product;
  final List<ServiceModel>? service;
  ItemRequestModel({
    this.id = 0,
    this.product,
    this.service,
  });

  factory ItemRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ItemRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemRequestModelToJson(this);
}
