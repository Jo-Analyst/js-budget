// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) => ContactModel(
      id: json['id'] as int? ?? 0,
      telePhone: json['tele_phone'] as String,
      cellPhone: json['cell_phone'] as String,
      email: json['email'] as String,
      clientId: json['client_id'] as int?,
    );

Map<String, dynamic> _$ContactModelToJson(ContactModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tele_phone': instance.telePhone,
      'cell_phone': instance.cellPhone,
      'email': instance.email,
      'client_id': instance.clientId,
    };
