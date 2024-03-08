// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      id: json['id'] as int? ?? 0,
      cep: json['cep'] as String?,
      district: json['district'] as String,
      streetAddress: json['street_address'] as String,
      numberAddress: json['number_address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      clientId: json['client_id'] as int?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cep': instance.cep,
      'district': instance.district,
      'street_address': instance.streetAddress,
      'number_address': instance.numberAddress,
      'city': instance.city,
      'state': instance.state,
      'client_id': instance.clientId,
    };
