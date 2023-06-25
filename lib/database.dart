import 'dart:async';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/moor.dart';

part 'database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withLength(min: 3, max: 32)();
  TextColumn get password => text().withLength(min: 6)();
}

@UseMoor(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.sqlite',
    logStatements: true,
  ));

  @override
  int get schemaVersion => 1;

  Future<User?> getUserByUsername(String username) async {
    final query = select(users)..where((t) => t.username.equals(username));
    final result = await query.get();

    if (result.isEmpty) {
      return null; // Retorna null quando nenhum usuário é encontrado
    } else {
      return result.single; // Retorna o único usuário encontrado
    }
  }

  Future<int> insertUser(UsersCompanion user) => into(users).insert(user);

  Future updateUser(UsersCompanion user) => update(users).replace(user);

  Future deleteUser(UsersCompanion user) => delete(users).delete(user);
}
