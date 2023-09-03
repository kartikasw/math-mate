import 'package:hive/hive.dart';

part 'history.g.dart';

@HiveType(typeId: 1)
class History extends HiveObject {
  static const String tableName = 'History';
  static const String colId = 'id';
  static const String colOperation = 'operation';
  static const String colResult = 'result';
  static const String colTimeStamp = 'timestamp';

  @HiveField(0)
  int id;

  @HiveField(1)
  final String operation;

  @HiveField(2)
  final String result;

  @HiveField(3)
  final String timestamp;

  History({
    this.id = 0,
    required this.operation,
    required this.result,
    required this.timestamp,
  });

  factory History.fromMapObject(Map<String, dynamic> map) => History(
        id: map[colId],
        operation: map[colOperation],
        result: map[colResult],
        timestamp: map[colTimeStamp],
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != 0) {
      map[colId] = id;
    }
    map[colOperation] = operation;
    map[colResult] = result;
    map[colTimeStamp] = timestamp.toString();
    return map;
  }

  void copyWith({int? id}) {
    this.id = id ?? this.id;
  }

  static String createTableQuery() => '''CREATE TABLE $tableName (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $colOperation TEXT,
      $colResult TEXT,
      $colTimeStamp TEXT)''';
}