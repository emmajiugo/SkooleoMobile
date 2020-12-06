import 'package:json_annotation/json_annotation.dart';
import 'package:skooleo/src/models/single_invoice/single_invoice_fee.dart';
import 'package:skooleo/src/models/single_invoice/single_invoice_school.dart';
import 'package:skooleo/src/models/single_invoice/single_invoice_student.dart';

part 'single_invoice.g.dart';

@JsonSerializable()
class SingleInvoice {
  @JsonKey(name: 'invoice_id')
  final int invoiceId;
  final String reference;
  @JsonKey(name: 'invoice_status')
  final String invoiceStatus;
  final double total;
  final String fee;
  @JsonKey(name: 'grand_total')
  final double grandTotal;
  final SingleInvoiceSchool school;
  final SingleInvoiceStudent student;
  @JsonKey(name: 'fee_breakdown')
  final List<SingleInvoiceFee> feeBreakdown;

  SingleInvoice(this.invoiceId, this.reference, this.invoiceStatus, this.total,
      this.fee, this.grandTotal, this.school, this.student, this.feeBreakdown);

  factory SingleInvoice.fromJson(Map<String, dynamic> json) =>
      _$SingleInvoiceFromJson(json);
}
