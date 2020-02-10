
import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domain/delivery/detail/delivery_detail_site.dart';
import 'package:pomangam_client/domain/sign/enum/sex.dart';

part 'user.g.dart';

@JsonSerializable(nullable: true)
class User {

  int idx;

  DeliveryDetailSite _deliveryDetailSite;
  get deliveryDetailSite => _deliveryDetailSite.toJson();
  set deliveryDetailSite(DeliveryDetailSite value) => _deliveryDetailSite = value;

  String phoneNumber;

  String password;

  String name;

  String nickname;

  Sex sex;

  DateTime birth;

  bool isActive;

  int point;

  User({this.idx, deliveryDetailSite, this.phoneNumber, this.password,
      this.name, this.nickname, this.sex, this.birth, this.isActive,
      this.point}): _deliveryDetailSite = deliveryDetailSite;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
  static List<User> fromJsonList(List<Map<String, dynamic>> jsonList) {
      List<User> entities = [];
      jsonList.forEach((map) => entities.add(User.fromJson(map)));
      return entities;
  }

  @override
  String toString() {
    return 'User{idx: $idx, phoneNumber: $phoneNumber, password: $password, name: $name, nickname: $nickname, sex: $sex, birth: $birth, isActive: $isActive, point: $point}';
  }


}