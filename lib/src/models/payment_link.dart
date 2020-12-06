import 'package:json_annotation/json_annotation.dart';

part 'payment_link.g.dart';

@JsonSerializable()
class PaymentLink {
  final String status;
  final String message;
  final String data;

  PaymentLink(this.status, this.message, this.data);

  factory PaymentLink.fromJson(Map<String, dynamic> json) =>
      _$PaymentLinkFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentLinkToJson(this);
}
