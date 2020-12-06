import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact {
  final String address;
  final String email;
  final String phone;

  Contact(this.address, this.email, this.phone);

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
}
