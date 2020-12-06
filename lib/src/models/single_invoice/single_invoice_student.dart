import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'single_invoice_student.g.dart';

@JsonSerializable()
class SingleInvoiceStudent {
  final String name;
  @JsonKey(name: 'class')
  final String className;
  final String term;
  final String session;
  @JsonKey(name: 'feetype')
  final String feeType;

  SingleInvoiceStudent(
      this.name, this.className, this.term, this.session, this.feeType);

  factory SingleInvoiceStudent.fromJson(Map<String, dynamic> json) =>
      _$SingleInvoiceStudentFromJson(json);
}
