import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart'
    show getApllicationDocumentsDirectory;
import 'package:sqflite/sqflite.dart';

@immutable
class DatabaseUser {
  final int id;
  final String email;
  const DatabaseUser({
    required this.id,
    required this.email,
  });

  DatabaseUser.formRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        email = map[emailColumn] as String;

  @override
  String toString() => 'Person, ID =$id, email = $email';

  @override
  bool operator ==(covariant DatabaseUser other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DatabaseNotes {
  final int id;
  final int userId;
  final String text;
  final bool syncWithCloud;

  DatabaseNotes({
    required this.id,
    required this.userId,
    required this.text,
    required this.syncWithCloud,
  });

  DatabaseNotes.formRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        userId = map[userIdColumn] as int,
        text = map[textColumn] as String,
        syncWithCloud = (map[syncWithCloudColumn] as int) == 1 ? true : false;

  @override
  String toString() => 'Note, ID =$id, userId = $userId, syncWithCloud = $syncWithCloud';
}

const idColumn = 'id';
const emailColumn = 'email';
const userIdColumn = 'user_id';
const textColumn = 'text';
const syncWithCloudColumn = 'syncWithCloud';
