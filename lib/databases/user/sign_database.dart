import 'package:path/path.dart';
import 'package:pomangam_client/domains/sign/user.dart';
import 'package:sqflite/sqflite.dart';

@deprecated
class SignDatabase {
  Future<Database> _database;

  Future<Database> _load() async {
    return _database ??= openDatabase(
      join(await getDatabasesPath(), 'pomangam_client_database.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
        '''
          create table user(
            idx INTEGER PRIMARY KEY, 
            idxDeliverySite INTEGER,
            idxDeliveryDetailSite INTEGER,
            phoneNumber TEXT,
            name TEXT,
            nickname TEXT,
            sex TEXT,
            birth TEXT,
            isActive INTEGER,
            point INTEGER
          )
        '''
        );
      },
    );
  }

  Future<void> insert(User user) async {
    final Database db = await _load();
    if(await hasUser()) {
      db.delete('user');
    }
    await db.insert(
      'user',
      {
        'idx': 2,
        'idxDeliverySite': 2,
        'idxDeliveryDetailSite': 3,
        'phoneNumber': '',
        'name': '',
        'nickname': '',
        'sex': '',
        'birth': '',
        'isActive': 1,  // 0 false, 1 true
        'point': 123
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(User user) async {
    final Database db = await _load();
    await db.update(
      'user',
      user.toJson(),
      where: "idx = ?",
      whereArgs: [user.idx],
    );
  }

  Future<bool> hasUser() async {
    final Database db = await _load();
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM user')) >= 1;
  }

  Future<User> getUser() async {
    final Database db = await _load();
    print((await db.query('user')));
    return null;
    //return User.fromJson((await db.query('user')).first);
  }
}