import 'package:json_annotation/json_annotation.dart';

part 'single_invoice_school.g.dart';

@JsonSerializable()
class SingleInvoiceSchool {
  final String name;
  final String address;
  final String email;
  final String phone;

  SingleInvoiceSchool(this.name, this.address, this.email, this.phone);

  factory SingleInvoiceSchool.fromJson(Map<String, dynamic> json) =>
      _$SingleInvoiceSchoolFromJson(json);
}
