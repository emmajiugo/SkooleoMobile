// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleInvoice _$SingleInvoiceFromJson(Map<String, dynamic> json) {
  return SingleInvoice(
    json['invoice_id'] as int,
    json['reference'] as String,
    json['invoice_status'] as String,
    (json['total'] as num)?.toDouble(),
    json['fee'] as String,
    (json['grand_total'] as num)?.toDouble(),
    json['school'] == null
        ? null
        : SingleInvoiceSchool.fromJson(json['school'] as Map<String, dynamic>),
    json['student'] == null
        ? null
        : SingleInvoiceStudent.fromJson(
            json['student'] as Map<String, dynamic>),
    (json['fee_breakdown'] as List)
        ?.map((e) => e == null
            ? null
            : SingleInvoiceFee.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SingleInvoiceToJson(SingleInvoice instance) =>
    <String, dynamic>{
      'invoice_id': instance.invoiceId,
      'reference': instance.reference,
      'invoice_status': instance.invoiceStatus,
      'total': instance.total,
      'fee': instance.fee,
      'grand_total': instance.grandTotal,
      'school': instance.school,
      'student': instance.student,
      'fee_breakdown': instance.feeBreakdown,
    };
