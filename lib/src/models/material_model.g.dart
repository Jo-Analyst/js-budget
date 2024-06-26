// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialModel _$MaterialModelFromJson(Map<String, dynamic> json) =>
    MaterialModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String,
      type: json['type'] as String?,
      unit: json['unit'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] as int? ?? 1,
      lastQuantityAdded: json['last_quantity_added'] as int? ?? 1,
      observation: json['observation'] as String?,
      dateOfLastPurchase: json['date_of_last_purchase'] as String?,
      supplier: json['supplier'] as String?,
    );

Map<String, dynamic> _$MaterialModelToJson(MaterialModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'unit': instance.unit,
      'price': instance.price,
      'quantity': instance.quantity,
      'last_quantity_added': instance.lastQuantityAdded,
      'observation': instance.observation,
      'date_of_last_purchase': instance.dateOfLastPurchase,
      'supplier': instance.supplier,
    };
