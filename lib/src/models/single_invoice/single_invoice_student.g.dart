// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_invoice_student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleInvoiceStudent _$SingleInvoiceStudentFromJson(Map<String, dynamic> json) {
  return SingleInvoiceStudent(
    json['name'] as String,
    json['class'] as String,
    json['term'] as String,
    json['session'] as String,
    json['feetype'] as String,
  );
}

Map<String, dynamic> _$SingleInvoiceStudentToJson(
        SingleInvoiceStudent instance) =>
    <String, dynamic>{
      'name': instance.name,
      'class': instance.className,
      'term': instance.term,
      'session': instance.session,
      'feetype': instance.feeType,
    };
