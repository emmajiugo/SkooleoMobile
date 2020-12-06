import 'package:json_annotation/json_annotation.dart';

part 'single_invoice_fee.g.dart';

@JsonSerializable()
class SingleInvoiceFee {
  final String description;
  final double amount;

  SingleInvoiceFee(this.description, this.amount);

  factory SingleInvoiceFee.fromJson(Map<String, dynamic> json) =>
      _$SingleInvoiceFeeFromJson(json);
}
