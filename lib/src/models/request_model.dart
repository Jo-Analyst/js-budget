// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:js_budget/src/models/client_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:js_budget/src/models/item_request_model.dart';

part 'request_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RequestModel {
  final int id;
  final String date;
  final ClientModel client;
  final List<ItemRequestModel> items;
  RequestModel({
    this.id = 0,
    required this.date,
    required this.client,
    required this.items,
  });
  factory RequestModel.fromJson(Map<String, dynamic> json) =>
      _$RequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestModelToJson(this);
}
