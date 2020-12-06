import 'package:json_annotation/json_annotation.dart';
import 'package:skooleo/src/models/fee_type.dart';
import 'package:skooleo/src/models/session.dart';

part 'school_detail.g.dart';

@JsonSerializable()
class SchoolDetail {
  @JsonKey(name: 'schoolid')
  final int schoolId;
  @JsonKey(name: 'schoolname')
  final String schoolName;
  @JsonKey(name: 'schooladdress')
  final String schoolAddress;
  @JsonKey(name: 'schoolemail')
  final String schoolEmail;
  @JsonKey(name: 'schoolphone')
  final String schoolPhone;
  @JsonKey(name: 'feetypes')
  final List<FeeType> feeTypes;
  @JsonKey(name: 'session')
  final List<Session> sessions;

  SchoolDetail(this.schoolId, this.schoolName, this.schoolAddress,
      this.schoolEmail, this.schoolPhone, this.feeTypes, this.sessions);

  factory SchoolDetail.fromJson(Map<String, dynamic> json) =>
      _$SchoolDetailFromJson(json);
}
