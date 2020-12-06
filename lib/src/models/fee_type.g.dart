// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeeType _$FeeTypeFromJson(Map<String, dynamic> json) {
  return FeeType(
    json['id'] as int,
    json['feename'] as String,
  );
}

Map<String, dynamic> _$FeeTypeToJson(FeeType instance) => <String, dynamic>{
      'id': instance.id,
      'feename': instance.feeName,
    };
