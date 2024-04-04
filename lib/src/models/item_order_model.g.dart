// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemOrderModel _$ItemOrderModelFromJson(Map<String, dynamic> json) =>
    ItemOrderModel(
      id: json['id'] as int? ?? 0,
      products: json['products'] == null
          ? null
          : ProductModel.fromJson(json['products'] as Map<String, dynamic>),
      services: json['services'] == null
          ? null
          : ServiceModel.fromJson(json['services'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemOrderModelToJson(ItemOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'products': instance.products,
      'services': instance.services,
    };
