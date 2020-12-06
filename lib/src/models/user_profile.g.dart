// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile(
    json['id'] as int,
    json['fullname'] as String,
    json['email'] as String,
    json['phone'] as String,
    json['created_at'] as String,
  );
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'created_at': instance.createdAt,
    };
