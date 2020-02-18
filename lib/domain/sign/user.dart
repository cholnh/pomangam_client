
import 'package:json_annotation/json_annotation.dart';
import 'package:pomangam_client/domain/delivery/delivery_site.dart';
import 'package:pomangam_client/domain/delivery/detail/delivery_detail_site.dart';
import 'package:pomangam_client/domain/sign/enum/sex.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomangam_client/common/key/shared_preference_key.dart' as s;

part 'user.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class User {

  int idx;

  DeliveryDetailSite deliveryDetailSite;

  String phoneNumber;

  String password;

  String name;

  String nickname;

  Sex sex;

  DateTime birth;

  bool isActive;

  int point;

  User({this.idx, this.deliveryDetailSite, this.phoneNumber, this.password,
      this.name, this.nickname, this.sex, this.birth, this.isActive,
      this.point});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
  static List<User> fromJsonList(List<Map<String, dynamic>> jsonList) {
      List<User> entities = [];
      jsonList.forEach((map) => entities.add(User.fromJson(map)));
      return entities;
  }

  static Future<User> loadFromDisk() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return User(
        idx: prefs.get(s.userIdx),
        deliveryDetailSite:  DeliveryDetailSite(
            idx: prefs.getInt(s.idxDeliveryDetailSite),
            deliverySite: DeliverySite(
              idx: prefs.getInt(s.idxDeliverySite)
            )
        ),
        phoneNumber: prefs.get(s.userPhoneNumber),
        name: prefs.get(s.userName),
        nickname: prefs.get(s.userNickname),
        sex: prefs.get(s.userSex) == 'MALE' ? Sex.MALE : Sex.FEMALE,
        birth: DateTime.parse(prefs.get(s.userBirth)),
        isActive: prefs.get(s.userIsActive),
        point: prefs.get(s.userPoint)
      );
    } catch (e) {}
    return null;
  }

  Future<User> saveToDisk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(s.userIdx, this.idx);
    prefs.setInt(s.idxDeliveryDetailSite, this.deliveryDetailSite?.idx);
    prefs.setInt(s.idxDeliverySite, this.deliveryDetailSite?.deliverySite?.idx);
    prefs.setString(s.userPhoneNumber, this.phoneNumber);
    prefs.setString(s.userName, this.name);
    prefs.setString(s.userNickname, this.nickname);
    prefs.setString(s.userSex, this.sex.toString());
    prefs.setString(s.userBirth, this.birth?.toIso8601String());
    prefs.setBool(s.userIsActive, this.isActive);
    prefs.setInt(s.userPoint, this.point);
    return this;
  }

  static Future<void> clearFromDisk() async {
    await SharedPreferences.getInstance()
      ..remove(s.userIdx)
      ..remove(s.idxDeliveryDetailSite)
      ..remove(s.idxDeliverySite)
      ..remove(s.userPhoneNumber)
      ..remove(s.userName)
      ..remove(s.userNickname)
      ..remove(s.userSex)
      ..remove(s.userBirth)
      ..remove(s.userIsActive)
      ..remove(s.userPoint);
  }

  @override
  String toString() {
    return 'User{idx: $idx, phoneNumber: $phoneNumber, password: $password, name: $name, nickname: $nickname, sex: $sex, birth: $birth, isActive: $isActive, point: $point}';
  }
}