// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:js_budget/src/models/address_model.dart';
import 'package:js_budget/src/models/contact_model.dart';

part 'profile_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileModel {
  final String corporateReason;
  final String name;
  final String cnpj;
  final ContactModel contact;
  final AddressModel address;
  ProfileModel({
    required this.corporateReason,
    required this.name,
    required this.cnpj,
    required this.contact,
    required this.address,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
