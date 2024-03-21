// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'contact_model.g.dart';

@JsonSerializable()
class ContactModel {
  final int id;
  final String? telePhone;
  final String cellPhone;
  final String? email;
  ContactModel({
    this.id = 0,
    this.telePhone,
    required this.cellPhone,
    this.email,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
}
