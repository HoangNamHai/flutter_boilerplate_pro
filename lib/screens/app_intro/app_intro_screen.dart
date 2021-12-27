import 'package:flutter/material.dart';
import 'package:flutter_app/screens/homepage/homepage_screen.dart';
import 'package:flutter_app/utils/styles.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:logger/logger.dart';
import '../../utils/custom_printer.dart';
import './app_intro_screen_controller.dart';

var logger = Logger(
  printer: CustomPrinter('AppIntroScreen'),
);

class AppIntroScreen extends StatefulWidget {
  static String tag = '/app_intro';

  AppIntroScreen({Key? key}) : super(key: key);

  @override
  _AppIntroScreen createState() => _AppIntroScreen();
}

class _AppIntroScreen extends State<AppIntroScreen> {
  final AppIntroController appIntroController = Get.put(AppIntroController());
  final introKey = GlobalKey<IntroductionScreenState>();
  late final List<PageViewModel> pages;

  var pageDecoration = PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
    bodyTextStyle: TextStyle(fontSize: 19.0),
    descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    pageColor: Colors.grey.shade900,
    imagePadding: EdgeInsets.zero,
  );

  Widget _buildImage(String assetName, [double width = 320]) {
    return Image.asset('assets/intro/$assetName', width: width);
  }

  @override
  void initState() {
    logger.v("AppIntroScreen init");
    super.initState();
    pages = [
      PageViewModel(
        // titleWidget: Text("Custom widget for title"),
        title: "Custom widget for title",
        body: "Instead of having to buy an entire share, invest any amount you want.",
        image: _buildImage('img1.jpg'),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: "Learn as you go",
        body: "Download the Stockpile app and master the market with our mini-lesson.",
        image: _buildImage('img2.jpg'),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: "Kids and teens",
        body: "Kids and teens can track their stocks 24/7 and place trades that you approve.",
        image: _buildImage('img3.jpg'),
        decoration: pageDecoration,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.grey.shade900,
      pages: pages,
      onDone: () => Get.offAndToNamed(HomePageScreen.tag),
      onSkip: () => Get.offAndToNamed(HomePageScreen.tag),
      showSkipButton: true,
      showDoneButton: true,
      skipFlex: 0,
      nextFlex: 0,
      // skip: const Text('Skip'),
      next: Container(), // const Icon(Icons.arrow_forward),
      done: 'Done'.h4(),
      skip: 'Skip'.h4(),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }
}
