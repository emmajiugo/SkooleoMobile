// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchoolDetail _$SchoolDetailFromJson(Map<String, dynamic> json) {
  return SchoolDetail(
    json['schoolid'] as int,
    json['schoolname'] as String,
    json['schooladdress'] as String,
    json['schoolemail'] as String,
    json['schoolphone'] as String,
    (json['feetypes'] as List)
        ?.map((e) =>
            e == null ? null : FeeType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['session'] as List)
        ?.map((e) =>
            e == null ? null : Session.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SchoolDetailToJson(SchoolDetail instance) =>
    <String, dynamic>{
      'schoolid': instance.schoolId,
      'schoolname': instance.schoolName,
      'schooladdress': instance.schoolAddress,
      'schoolemail': instance.schoolEmail,
      'schoolphone': instance.schoolPhone,
      'feetypes': instance.feeTypes,
      'session': instance.sessions,
    };
