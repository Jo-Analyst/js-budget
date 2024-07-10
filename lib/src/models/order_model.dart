// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:js_budget/src/models/client_model.dart';
import 'package:js_budget/src/models/item_order_model.dart';

part 'order_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderModel {
  int id;
  final String date;
  final ClientModel client;
  final List<ItemOrderModel> items;
  final String? status;
  final String? observation;
  OrderModel({
    this.id = 0,
    required this.date,
    required this.client,
    required this.items,
    this.status = 'Aguardando orçamento',
    this.observation,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
