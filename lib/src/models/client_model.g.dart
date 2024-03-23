// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientModel _$ClientModelFromJson(Map<String, dynamic> json) => ClientModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String,
      document: json['document'] as String?,
      isALegalEntity: json['isALegalEntity'] as bool? ?? false,
      contact: json['contact'] == null
          ? null
          : ContactModel.fromJson(json['contact'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClientModelToJson(ClientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'document': instance.document,
      'isALegalEntity': instance.isALegalEntity,
      'contact': instance.contact,
      'address': instance.address,
    };
