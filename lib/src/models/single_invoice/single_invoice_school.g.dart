// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_invoice_school.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleInvoiceSchool _$SingleInvoiceSchoolFromJson(Map<String, dynamic> json) {
  return SingleInvoiceSchool(
    json['name'] as String,
    json['address'] as String,
    json['email'] as String,
    json['phone'] as String,
  );
}

Map<String, dynamic> _$SingleInvoiceSchoolToJson(
        SingleInvoiceSchool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'email': instance.email,
      'phone': instance.phone,
    };
