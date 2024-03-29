import 'dart:async';
import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/controllers/app_controller.dart';
import 'package:flutter_app/firebase_options.dart';
import 'package:flutter_app/screens/homepage/homepage_screen.dart';
import 'package:flutter_app/utils/consts.dart';
import 'package:get/get.dart';
import 'package:sqlite3/sqlite3.dart';

void testSqliteFeatures() {
  // Create a new in-memory database. To use a database backed by a file, you
  // can replace this with sqlite3.open(yourFilePath).
  final db = sqlite3.openInMemory();

  // Create a table and insert some data
  db.execute('''
    CREATE TABLE artists (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL
    );
  ''');

  // Prepare a statement to run it multiple times:
  final stmt = db.prepare('INSERT INTO artists (name) VALUES (?)');
  stmt
    ..execute(['The Beatles'])
    ..execute(['Led Zeppelin'])
    ..execute(['The Who'])
    ..execute(['Nirvana']);

  // Dispose a statement when you don't need it anymore to clean up resources.
  stmt.dispose();

  // You can run select statements with PreparedStatement.select, or directly
  // on the database:
  final ResultSet resultSet = db.select('SELECT * FROM artists WHERE name LIKE ?', ['The %']);

  // You can iterate on the result set in multiple ways to retrieve Row objects
  // one by one.
  for (final row in resultSet) {
    print('Artist[id: ${row['id']}, name: ${row['name']}]');
  }

  // Register a custom function we can invoke from sql:
  db.createFunction(
    functionName: 'dart_version',
    argumentCount: const AllowedArgumentCount(0),
    function: (args) => Platform.version,
  );
  print(db.select('SELECT dart_version()'));
  print(db.select("SELECT json_array_length('[1,2,3,4]') "));
  print(db.select("""SELECT json_extract('{"a":2,"c":[4,5],"f":7}','\$.c','\$.a') """));

  // Don't forget to dispose the database to avoid memory leaks
  db.dispose();
}

Future<void> configFirebaseModules() async {
  FirebaseApp defaultApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Force disable Crashlytics collection while doing every day development.
  // Temporarily toggle this to true if you want to test crash reporting in your app.
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  print(defaultApp);
  print(FirebaseCrashlytics.instance);
  print(analytics);
  // The following lines are the same as previously explained in "Handling uncaught errors"
  // REF: https://firebase.flutter.dev/docs/crashlytics/usage
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
}

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await configFirebaseModules();
    Get.config(enableLog: true);
    testSqliteFeatures();
    // Prefer using app in portrait mode only
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    ).then(
      (value) => runApp(MyApp()),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp defaultApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    Get.put(AppController(), permanent: true);
    return GetMaterialApp(
      title: kAppTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: kPrimarySwatch,
        accentColor: kAccentColor,
        brightness: kUseDarkTheme ? Brightness.dark : Brightness.light,
      ),
      // home: HomePageScreen(title: kAppTitle),
      navigatorObservers: <NavigatorObserver>[observer],
      initialRoute: HomePageScreen.tag,
      getPages: [
        GetPage(name: HomePageScreen.tag, page: () => HomePageScreen(title: 'Home')),
      ],
      routingCallback: (routing) {
        print('routingCallback $routing');
      },
    );
  }
}
