import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AddressModel {
  AddressModel({
    this.id = 0,
    required this.cep,
    required this.district,
    required this.streetAddress,
    required this.numberAddress,
    required this.city,
    required this.state,
    this.clientId,
    this.profileId,
  });

  int id;
  final String cep;
  final String district;
  final String streetAddress;
  final String numberAddress;
  final String city;
  final String state;
  final int? clientId;
  final int? profileId;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
