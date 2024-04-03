// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemOrderModel _$ItemOrderModelFromJson(Map<String, dynamic> json) =>
    ItemOrderModel(
      id: json['id'] as int? ?? 0,
      product: (json['product'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      service: (json['service'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemOrderModelToJson(ItemOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
      'service': instance.service,
    };
