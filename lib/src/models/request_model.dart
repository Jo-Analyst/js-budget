// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'request_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RequestModel {
  final int id;
  final String date;
  final int clientId;
  RequestModel({
    this.id = 0,
    required this.date,
    required this.clientId,
  });
  factory RequestModel.fromJson(Map<String, dynamic> json) =>
      _$RequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestModelToJson(this);
}
