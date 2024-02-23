import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AddressModel {
  AddressModel({
    required this.id,
    required this.streetAddress,
    required this.numberAddress,
    required this.city,
    required this.state,
    required this.clientId,
  });

  @JsonKey(defaultValue: 0)
  final int id;
  final String streetAddress;
  final String numberAddress;
  final String city;
  final String state;
  final int clientId;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
