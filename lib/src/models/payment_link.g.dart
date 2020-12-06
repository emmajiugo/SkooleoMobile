// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentLink _$PaymentLinkFromJson(Map<String, dynamic> json) {
  return PaymentLink(
    json['status'] as String,
    json['message'] as String,
    json['data'] as String,
  );
}

Map<String, dynamic> _$PaymentLinkToJson(PaymentLink instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
