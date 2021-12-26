import 'package:flutter_app/utils/custom_printer.dart';
import 'package:flutter_app/utils/in_app_purchases.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

var logger = Logger(
  printer: CustomPrinter('AppController'),
);

class AppController extends GetxController {
  var iState = 0.obs; // Status count; used for Rx
  User? user;
  var offerings;
  var purchaserInfo;
  bool isEntitlementActivated = false;

  Future<PurchaserInfo> purchase(Package? selectedPackage) async {
    PurchaserInfo info = await Purchases.purchasePackage(selectedPackage as Package);
    purchaserInfo = info;
    iState++;
    return info;
  }

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
      logger.e(e);
    }
  }

  void _initInAppPurchasing() async {
    logger.v('_initInAppPurchasing v2');
    Purchases.setup(kRevCatApiKey, appUserId: null, observerMode: false);
    logger.v(Purchases);
    await Purchases.setDebugLogsEnabled(true);
    offerings = await Purchases.getOfferings();
    logger.v(offerings);
    Purchases.addPurchaserInfoUpdateListener((purchaserInfo) async {
      purchaserInfo = await Purchases.getPurchaserInfo();
      String appUserID = await Purchases.appUserID;
      logger.w('addPurchaserInfoUpdateListener appUserID: $appUserID');
      logger.w('purchaserInfo: $purchaserInfo');
      (purchaserInfo.entitlements.all[kEntitlementID] != null && purchaserInfo.entitlements.all[kEntitlementID]!.isActive) ? isEntitlementActivated = true : isEntitlementActivated = false;
      iState++;
      logger.w('addPurchaserInfoUpdateListener entitlement: $isEntitlementActivated');
    });
  }

  @override
  void onInit() {
    super.onInit();
    _initFirebaseEventHandler();
    _signInAnonymously();
    _initInAppPurchasing();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
