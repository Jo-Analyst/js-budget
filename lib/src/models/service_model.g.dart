// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      id: json['id'] as int? ?? 0,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int? ?? 1,
    );

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'price': instance.price,
      'quantity': instance.quantity,
    };
