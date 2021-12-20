import 'package:flutter_app/utils/custom_printer.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';

var logger = Logger(
  printer: CustomPrinter('AppController'),
);

class AppController extends GetxController {
  var iState = 0.obs; // Status count; used for Rx
  User? user;

  void _initFirebaseEventHandler() {
    logger.v('_initFirebaseEventHandler');
    FirebaseAuth.instance.authStateChanges().listen((User? _user) {
      user = _user;
      iState++;
      logger.w('[AuthStateChanged] $user');
    });
  }

  void _signInAnonymously() async {
    try {
      logger.v('_signInAnonymously');
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _initFirebaseEventHandler();
    _signInAnonymously();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
