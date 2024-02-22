// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cost_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CostModel _$CostModelFromJson(Map<String, dynamic> json) => CostModel(
      id: json['id'] as int? ?? 0,
      description: json['description'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$CostModelToJson(CostModel instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'value': instance.value,
    };
