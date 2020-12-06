import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Login {
  final String emailPhone;
  final String password;

  Login(this.emailPhone, this.password);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
