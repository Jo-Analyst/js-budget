// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      id: json['id'] as int? ?? 0,
      corporateReason: json['corporate_reason'] as String,
      fantasyName: json['fantasy_name'] as String,
      document: json['document'] as String,
      contact: ContactModel.fromJson(json['contact'] as Map<String, dynamic>),
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      salaryExpectation: (json['salary_expectation'] as num).toDouble(),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'corporate_reason': instance.corporateReason,
      'fantasy_name': instance.fantasyName,
      'document': instance.document,
      'contact': instance.contact,
      'address': instance.address,
      'salary_expectation': instance.salaryExpectation,
    };
