// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as int? ?? 0,
      date: json['date'] as String,
      client: ClientModel.fromJson(json['client'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>)
          .map((e) => ItemOrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'client': instance.client,
      'items': instance.items,
    };
