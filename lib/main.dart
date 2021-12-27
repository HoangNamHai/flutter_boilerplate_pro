import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/controllers/app_controller.dart';
import 'package:flutter_app/screens/app_intro/app_intro_screen.dart';
import 'package:flutter_app/screens/homepage/homepage_screen.dart';
import 'package:flutter_app/utils/consts.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.config(enableLog: true);
  await Firebase.initializeApp();
  // Prefer using app in portrait mode only
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then(
    (value) => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
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
      initialRoute: HomePageScreen.tag,
      getPages: [
        GetPage(name: HomePageScreen.tag, page: () => HomePageScreen(title: 'Home')),
        GetPage(name: AppIntroScreen.tag, page: () => AppIntroScreen()),
      ],
    );
  }
}
