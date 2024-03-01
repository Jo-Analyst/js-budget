// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'client_model.g.dart';

@JsonSerializable()
class ClientModel {
  ClientModel({
    this.id = 0,
    required this.name,
    this.phone,
    required this.cpf,
  });

  final int id;
  final String name;
  final String? phone;
  final String cpf;

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClientModelToJson(this);

  

  @override
  String toString() {
    return 'ClientModel(id: $id, name: $name, phone: $phone, cpf: $cpf)';
  }
}
