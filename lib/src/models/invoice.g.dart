// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return Invoice(
    json['invoice_reference'] as String,
    json['studentname'] as String,
    json['status'] as String,
    (json['amount'] as num)?.toDouble(),
    json['class'] as String,
    json['term'] as String,
    json['session'] as String,
  );
}

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'invoice_reference': instance.invoiceReference,
      'studentname': instance.studentName,
      'status': instance.status,
      'amount': instance.amount,
      'class': instance.className,
      'term': instance.term,
      'session': instance.session,
    };
