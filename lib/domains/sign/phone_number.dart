
import 'package:json_annotation/json_annotation.dart';

part 'phone_number.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class PhoneNumber {

  String phoneNumber;

  String code;

  PhoneNumber({this.phoneNumber, this.code});
  factory PhoneNumber.fromJson(Map<String, dynamic> json) => _$PhoneNumberFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneNumberToJson(this);
}