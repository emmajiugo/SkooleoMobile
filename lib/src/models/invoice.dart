import 'package:json_annotation/json_annotation.dart';
part 'invoice.g.dart';

@JsonSerializable()
class Invoice {
  @JsonKey(name: 'invoice_reference')
  final String invoiceReference;
  @JsonKey(name: 'studentname')
  final String studentName;
  final String status;
  final double amount;
  @JsonKey(name: 'class')
  final String className;
  final String term;
  final String session;

  Invoice(this.invoiceReference, this.studentName, this.status, this.amount,
      this.className, this.term, this.session);

  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}