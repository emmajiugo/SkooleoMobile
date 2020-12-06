import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  final int id;
  @JsonKey(name: 'fullname')
  final String fullName;
  final String email;
  final String phone;
  @JsonKey(name: 'created_at')
  final String createdAt;

  UserProfile(this.id, this.fullName, this.email, this.phone, this.createdAt);

  factory UserProfile.fromJson(Map<String, dynamic> data) =>
      _$UserProfileFromJson(data);
}
