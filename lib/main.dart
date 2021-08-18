import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate_pro/controllers/app_controller.dart';
import 'package:flutter_boilerplate_pro/screens/home_page_screen.dart';
import 'package:flutter_boilerplate_pro/utils/consts.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.config(enableLog: true);
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
      home: HomePageScreen(title: kAppTitle),
    );
  }
}
