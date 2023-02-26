import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

const String dbFilename = 'restaurants.db';
var logger = getLogger('SqliteService');

class SqliteService extends GetxService {
  // late Database instance;
  late final Directory tempDir;
  late final Directory appDocDir;
  late final Database db;

  void testDatabase() {
    var result = db.select('SELECT * FROM businesses LIMIT 5');
    for (var row in result) {
      print(row);
    }
    db.createFunction(
      functionName: 'dart_version',
      argumentCount: const AllowedArgumentCount(0),
      function: (args) => Platform.version,
    );
    print(db.select('SELECT dart_version()'));
    print(db.select("SELECT json_array_length('[1,2,3,4]') "));
    print(db.select("""SELECT json_extract('{"a":2,"c":[4,5],"f":7}','\$.c','\$.a') """));
  }

  Future<SqliteService> init() async {
    var startedAt = DateTime.now().millisecondsSinceEpoch;
    tempDir = await getTemporaryDirectory();
    appDocDir = await getApplicationDocumentsDirectory();
    logger.i('Temporary path: ${tempDir.path}');
    logger.i('Application document path: ${appDocDir.path}');
    var dbPath = join(appDocDir.path, dbFilename);
    bool isDbExists = File(dbPath).existsSync();
    logger.i('SqliteDb file: $dbPath -> Exists: $isDbExists');
    if (!isDbExists) {
      await copyFileToWorkspace(dbPath);
    }
    db = sqlite3.open(dbPath);
    testDatabase();
    logger.w('SqliteService inited: ${DateTime.now().millisecondsSinceEpoch - startedAt} ms');
    return this;
  }

  Future<void> copyFileToWorkspace(String path) async {
    var startedAt = DateTime.now().millisecondsSinceEpoch;
    try {
      await Directory(dirname(path)).create(recursive: true);
      ByteData data = await rootBundle.load(join("assets", dbFilename));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
      logger.w('copyFileToWorkspace finished: ${DateTime.now().millisecondsSinceEpoch - startedAt} ms');
    } catch (e) {
      logger.e(e);
    }
  }

  void dispose() {
    db.dispose();
  }
}
