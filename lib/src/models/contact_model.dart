// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'contact_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ContactModel {
  final int id;
  final String telePhone;
  final String cellPhone;
  final String email;
  final int? clientId;
  final int? profileId;
  
  ContactModel({
    this.id = 0,
    required this.telePhone,
    required this.cellPhone,
    required this.email,
    this.clientId,
    this.profileId,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
}
