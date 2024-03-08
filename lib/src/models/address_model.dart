// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AddressModel {
  AddressModel({
    this.id = 0,
    this.cep,
    required this.district,
    required this.streetAddress,
    required this.numberAddress,
    required this.city,
    required this.state,
    this.clientId,
  });

  final int id;
  final String? cep;
  final String district;
  final String streetAddress;
  final String numberAddress;
  final String city;
  final String state;
  final int? clientId;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
