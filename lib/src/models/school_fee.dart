import 'package:json_annotation/json_annotation.dart';

part 'school_fee.g.dart';

@JsonSerializable()
class SchoolFee {
  @JsonKey(name: 'school_id')
  final int schoolId;
  @JsonKey(name: 'feesetup_id')
  final int feeSetupId;
  final String amount;
  @JsonKey(name: 'fee_name')
  final String feeName;
  final String section;
  final String session;
  final String term;
  @JsonKey(name: 'class')
  final String className;
  @JsonKey(name: 'school_name')
  final String schoolName;
  @JsonKey(name: 'school_address')
  final String schoolAddress;

  SchoolFee(
    this.schoolId,
    this.feeSetupId,
    this.amount,
    this.feeName,
    this.section,
    this.session,
    this.term,
    this.className,
    this.schoolName,
    this.schoolAddress,
  );

  factory SchoolFee.fromJson(Map<String, dynamic> json) =>
      _$SchoolFeeFromJson(json);
}
