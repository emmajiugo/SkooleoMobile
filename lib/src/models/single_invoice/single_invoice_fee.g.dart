// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_invoice_fee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleInvoiceFee _$SingleInvoiceFeeFromJson(Map<String, dynamic> json) {
  return SingleInvoiceFee(
    json['description'] as String,
    (json['amount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SingleInvoiceFeeToJson(SingleInvoiceFee instance) =>
    <String, dynamic>{
      'description': instance.description,
      'amount': instance.amount,
    };
