// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemOrderModel _$ItemOrderModelFromJson(Map<String, dynamic> json) =>
    ItemOrderModel(
      id: json['id'] as int? ?? 0,
      quantityProduct: json['quantity_product'] as int?,
      quantityService: json['quantity_service'] as int?,
      product: json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      service: json['service'] == null
          ? null
          : ServiceModel.fromJson(json['service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemOrderModelToJson(ItemOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity_product': instance.quantityProduct,
      'quantity_service': instance.quantityService,
      'product': instance.product,
      'service': instance.service,
    };
