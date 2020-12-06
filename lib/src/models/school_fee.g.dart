// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_fee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchoolFee _$SchoolFeeFromJson(Map<String, dynamic> json) {
  return SchoolFee(
    json['school_id'] as int,
    json['feesetup_id'] as int,
    json['amount'] as String,
    json['fee_name'] as String,
    json['section'] as String,
    json['session'] as String,
    json['term'] as String,
    json['class'] as String,
    json['school_name'] as String,
    json['school_address'] as String,
  );
}

Map<String, dynamic> _$SchoolFeeToJson(SchoolFee instance) => <String, dynamic>{
      'school_id': instance.schoolId,
      'feesetup_id': instance.feeSetupId,
      'amount': instance.amount,
      'fee_name': instance.feeName,
      'section': instance.section,
      'session': instance.session,
      'term': instance.term,
      'class': instance.className,
      'school_name': instance.schoolName,
      'school_address': instance.schoolAddress,
    };
