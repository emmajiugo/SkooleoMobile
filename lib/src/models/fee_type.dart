import 'package:json_annotation/json_annotation.dart';

part 'fee_type.g.dart';

@JsonSerializable()
class FeeType {
  final int id;
  @JsonKey(name: 'feename')
  final String feeName;

  FeeType(this.id, this.feeName);

  factory FeeType.fromJson(Map<String, dynamic> json) =>
      _$FeeTypeFromJson(json);
}
