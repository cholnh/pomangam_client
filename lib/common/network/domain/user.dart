class User {


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
  User({this.idx, this.deliverySiteIdx, this.id, this.pw, this.name,
      this.nickname, this.gender, this.yearOfBirth, this.monthOfBirth,
      this.daysOfBirth, this.phoneNumber, this.stateActive, this.registerDate,
      this.modifyDate, this.point});

  User.fromJson(Map<String, dynamic> json) :
        idx = json['idx'],
        deliverySiteIdx = json['delivery_site_idx'],
        id = json['id'],
        pw = json['pw'],
        name = json['name'],
        nickname = json['nickname'],
        gender = json['gender'] == 0 ? false : true,
        yearOfBirth = json['year_of_birth'],
        monthOfBirth = json['month_of_birth'],
        daysOfBirth = json['days_of_birth'],
        phoneNumber = json['phone_number'],
        stateActive = json['state_active'] == 0 ? false : true,
        registerDate = DateTime.parse(json['register_date']),
        modifyDate =  DateTime.parse(json['modify_date']),
        point = json['point'];

  @override
  String toString() {
    return 'User{idx: $idx, deliverySiteIdx: $deliverySiteIdx, id: $id, pw: $pw, name: $name, nickname: $nickname, gender: $gender, yearOfBirth: $yearOfBirth, monthOfBirth: $monthOfBirth, daysOfBirth: $daysOfBirth, phoneNumber: $phoneNumber, stateActive: $stateActive, registerDate: $registerDate, modifyDate: $modifyDate, point: $point}';
  }
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
}