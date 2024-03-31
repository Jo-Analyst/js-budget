// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestModel _$RequestModelFromJson(Map<String, dynamic> json) => RequestModel(
      id: json['id'] as int? ?? 0,
      date: json['date'] as String,
      client: ClientModel.fromJson(json['client'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>)
          .map((e) => ItemRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequestModelToJson(RequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'client': instance.client,
      'items': instance.items,
    };
