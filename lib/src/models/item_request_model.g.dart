// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemRequestModel _$ItemRequestModelFromJson(Map<String, dynamic> json) =>
    ItemRequestModel(
      id: json['id'] as int? ?? 0,
      productId: json['product_id'] as int,
      serviceId: json['service_id'] as int,
    );

Map<String, dynamic> _$ItemRequestModelToJson(ItemRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'service_id': instance.serviceId,
    };
