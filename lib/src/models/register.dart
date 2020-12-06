import 'package:json_annotation/json_annotation.dart';

part 'register.g.dart';

@JsonSerializable()
class Register {
  @JsonKey(name: 'fullname')
  final String fullName;
  final String email;
  final String phone;
  final String password;
  @JsonKey(name: 'password_confirmation')
  final String passwordConfirmation;

  Register(this.fullName, this.email, this.phone, this.password,
      this.passwordConfirmation);

  Map<String, dynamic> toJson() => _$RegisterToJson(this);
}
