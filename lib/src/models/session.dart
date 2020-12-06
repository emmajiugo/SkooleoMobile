import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  @JsonKey(name: 'sessionname')
  final String sessionName;

  Session(this.sessionName);

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}
