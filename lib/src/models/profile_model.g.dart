// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      corporateReason: json['corporate_reason'] as String,
      name: json['name'] as String,
      cnpj: json['cnpj'] as String,
      contact: ContactModel.fromJson(json['contact'] as Map<String, dynamic>),
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'corporate_reason': instance.corporateReason,
      'name': instance.name,
      'cnpj': instance.cnpj,
      'contact': instance.contact,
      'address': instance.address,
    };