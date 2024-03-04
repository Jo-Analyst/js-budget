import 'package:json_annotation/json_annotation.dart';

part 'cost_model.g.dart';

@JsonSerializable()
class CostModel {
  final int id;
  final String description;
  final double value;

  CostModel({
    this.id = 0,
    required this.description,
    required this.value,
  });

  factory CostModel.fromJson(Map<String, dynamic> json) =>
      _$CostModelFromJson(json);

  Map<String, dynamic> toJson() => _$CostModelToJson(this);
}
