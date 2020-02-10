import 'package:json_annotation/json_annotation.dart';

part 'auth_code_result.g.dart';

@JsonSerializable(nullable: true)
class AuthCodeResult {

  String code;

  AuthCodeResult(this.code);

  factory AuthCodeResult.fromJson(Map<String, dynamic> json) => _$AuthCodeResultFromJson(json);
  Map<String, dynamic> toJson() => _$AuthCodeResultToJson(this);
}