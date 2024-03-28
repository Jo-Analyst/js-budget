// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'item_request_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemRequestModel {
  final int id;
  final int productId;
  final int serviceId;
  ItemRequestModel({
    this.id = 0,
    required this.productId,
    required this.serviceId,
  });

  factory ItemRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ItemRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemRequestModelToJson(this);
}
