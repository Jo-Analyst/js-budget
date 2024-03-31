// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemRequestModel _$ItemRequestModelFromJson(Map<String, dynamic> json) =>
    ItemRequestModel(
      id: json['id'] as int? ?? 0,
      product: (json['product'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      service: (json['service'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemRequestModelToJson(ItemRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
      'service': instance.service,
    };
