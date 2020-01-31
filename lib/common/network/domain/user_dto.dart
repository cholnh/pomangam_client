import 'package:pomangam_client/common/network/domain/user.dart';

class UserDto {


  //━━ class variables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  int idx;
  int deliverySiteIdx;
  String id;
  String pw;
  String name;
  String nickname;
  bool gender;
  int yearOfBirth;
  int monthOfBirth;
  int daysOfBirth;
  String phoneNumber;
  bool stateActive;
  DateTime registerDate;
  DateTime modifyDate;
  int point;
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ constructor ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  UserDto({this.idx, this.deliverySiteIdx, this.id, this.pw, this.name,
      this.nickname, this.gender, this.yearOfBirth, this.monthOfBirth,
      this.daysOfBirth, this.phoneNumber, this.stateActive, this.registerDate,
      this.modifyDate, this.point});

  User toEntity() => User(
      idx: idx,
      deliverySiteIdx: deliverySiteIdx,
      id: id,
      pw: pw,
      name: name,
      nickname: nickname,
      gender: gender,
      yearOfBirth: yearOfBirth,
      monthOfBirth: monthOfBirth,
      daysOfBirth: daysOfBirth,
      phoneNumber: phoneNumber,
      stateActive: stateActive,
      registerDate: registerDate,
      modifyDate: modifyDate,
      point: point
  );

  static List<User> toEntities(List<UserDto> dtos)
    => dtos.map((dto) => dto.toEntity()).toList();

  static UserDto fromEntity(User entity) => UserDto(
      idx: entity.idx,
      deliverySiteIdx: entity.deliverySiteIdx,
      id: entity.id,
      pw: entity.pw,
      name: entity.name,
      nickname: entity.nickname,
      gender: entity.gender,
      yearOfBirth: entity.yearOfBirth,
      monthOfBirth: entity.monthOfBirth,
      daysOfBirth: entity.daysOfBirth,
      phoneNumber: entity.phoneNumber,
      stateActive: entity.stateActive,
      registerDate: entity.registerDate,
      modifyDate: entity.modifyDate,
      point: entity.point
  );

  static List<UserDto> fromEntities(List<User> entities)
    => entities.map(fromEntity).toList();

  UserDto copyWith({
    int idx,
    int deliverySiteIdx,
    String id,
    String pw,
    String name,
    String nickname,
    bool gender,
    int yearOfBirth,
    int monthOfBirth,
    int daysOfBirth,
    String phoneNumber,
    bool stateActive,
    DateTime registerDate,
    DateTime modifyDate,
    int point
  }) {
    return UserDto(
      idx: idx ?? this.idx,
      deliverySiteIdx: deliverySiteIdx ?? this.deliverySiteIdx,
      id: id ?? this.id,
      pw: pw ?? this.pw,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      gender: gender ?? this.gender,
      yearOfBirth: yearOfBirth ?? this.yearOfBirth,
      monthOfBirth: monthOfBirth ?? this.monthOfBirth,
      daysOfBirth: daysOfBirth ?? this.daysOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      stateActive: stateActive ?? this.stateActive,
      registerDate: registerDate ?? this.registerDate,
      modifyDate: modifyDate ?? this.modifyDate,
      point: point ?? this.point
    );
  }

  @override
  String toString() {
    return 'UserDto{idx: $idx, deliverySiteIdx: $deliverySiteIdx, id: $id, pw: $pw, name: $name, nickname: $nickname, gender: $gender, yearOfBirth: $yearOfBirth, monthOfBirth: $monthOfBirth, daysOfBirth: $daysOfBirth, phoneNumber: $phoneNumber, stateActive: $stateActive, registerDate: $registerDate, modifyDate: $modifyDate, point: $point}';
  }
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
}