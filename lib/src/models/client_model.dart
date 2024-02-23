import 'package:json_annotation/json_annotation.dart';

part 'client_model.g.dart';

@JsonSerializable()
class ClientModel {
  ClientModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.cpf,
  });

 @JsonKey(defaultValue: 0)
  final int id;
  final String name;
  final String phone;
  final String cpf;

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClientModelToJson(this);
}
