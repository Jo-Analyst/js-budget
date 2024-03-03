// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/models/contact_model.dart';

part 'client_model.g.dart';

@JsonSerializable()
class ClientModel {
  ClientModel({
    this.id = 0,
    required this.name,
    this.contact,
    this.address,
  });

  final int id;
  final String name;
  final ContactModel? contact;
  final AddressModel? address;

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClientModelToJson(this);
}
