import 'package:flutter_app/utils/custom_printer.dart';
import 'package:flutter_app/utils/in_app_purchases_config.dart';
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

  void restorePurchase() async {
    try {
      PurchaserInfo restoredInfo = await Purchases.restoreTransactions();
      purchaserInfo = restoredInfo;
      iState++;
    } on Exception catch (e) {
      logger.e(e);
    }
  }

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
      // Only init IAP after user is logged in
      _initInAppPurchasing();
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
    Purchases.setup(kRevCatApiKey, appUserId: user!.uid, observerMode: false);
    await Purchases.setDebugLogsEnabled(true);
    offerings = await Purchases.getOfferings();
    purchaserInfo = await Purchases.getPurchaserInfo();
    // String appUserID = await Purchases.appUserID;
    (purchaserInfo.entitlements.all[kEntitlementID] != null && purchaserInfo.entitlements.all[kEntitlementID]!.isActive) ? isEntitlementActivated = true : isEntitlementActivated = false;
    logger.w('offerings: $offerings');
    logger.w('purchaserInfo: $purchaserInfo');
    // logger.w('appUserID: $appUserID');

    Purchases.addPurchaserInfoUpdateListener((pInfo) async {
      purchaserInfo = pInfo;
      (purchaserInfo.entitlements.all[kEntitlementID] != null && purchaserInfo.entitlements.all[kEntitlementID]!.isActive) ? isEntitlementActivated = true : isEntitlementActivated = false;
      logger.w('🟣 purchaserInfo: $purchaserInfo');
      logger.w('🟣 addPurchaserInfoUpdateListener entitlement: $isEntitlementActivated');
      iState++;
    });
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
