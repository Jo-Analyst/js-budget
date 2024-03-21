// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) => ContactModel(
      id: json['id'] as int? ?? 0,
      telePhone: json['telePhone'] as String?,
      cellPhone: json['cellPhone'] as String,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$ContactModelToJson(ContactModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'telePhone': instance.telePhone,
      'cellPhone': instance.cellPhone,
      'email': instance.email,
    };
