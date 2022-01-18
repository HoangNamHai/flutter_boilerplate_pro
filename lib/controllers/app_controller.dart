import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/utils/custom_printer.dart';
import 'package:flutter_app/utils/firebase.dart';
import 'package:flutter_app/utils/in_app_purchases_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

var logger = Logger(
  printer: CustomPrinter('AppController'),
);

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class AppController extends GetxController {
  var iState = 0.obs; // Status count; used for Rx
  var currentUser = Rx<User?>(null);
  var offerings;
  var purchaserInfo;
  Map<String, dynamic> userSettings = {};
  Map<String, dynamic> publicSettings = {};
  bool isEntitlementActivated = false;
  bool isUserSettingsLoaded = false;

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

  void loadPublicSettings() {
    logger.v('loadPublicSettings');
    firestore.collection(kPublicSettings).get().then((QuerySnapshot value) {
      value.docs.forEach((element) {
        publicSettings[element.id] = element.data();
      });
      print(publicSettings);
      isUserSettingsLoaded = true;
      iState++;
    });
  }

  void listenOnPublicSettings() {
    // NOTE: data loaded via stream will be available offline
    Stream pubSettingsStream = firestore.collection(kPublicSettings).snapshots();
    pubSettingsStream.listen((event) {
      event.docs.forEach((element) {
        publicSettings[element.id] = element.data();
      });
      print(publicSettings);
      isUserSettingsLoaded = true;
      iState++;
    });
  }

  void loadUserSettings() {
    logger.v('loadUserSettings');
    firestore.collection(kUserSettings).doc(currentUser.value?.uid).get().then((DocumentSnapshot value) {
      if (value.exists) {
        userSettings = value.data() as Map<String, dynamic>;
        logger.w('User id = ${currentUser.value?.uid}. Settings loaded: ${jsonEncode(userSettings)}');
        isUserSettingsLoaded = true;
        iState++;
      } else {
        logger.w('User id = ${currentUser.value?.uid}. Settings is empty');
        iState++;
      }
    });
  }

  void _initFirebaseEventHandler() {
    logger.v('_initFirebaseEventHandler');
    FirebaseAuth.instance.authStateChanges().listen((User? _user) {
      currentUser.value = _user;
      iState++;
      logger.w('[AuthStateChanged] $_user');
      // Only init IAP after user is logged in
      _initInAppPurchasing();
      loadUserSettings();
      listenOnPublicSettings();
      // loadPublicSettings();
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
    Purchases.setup(kRevCatApiKey, appUserId: currentUser.value!.uid, observerMode: false);
    await Purchases.setDebugLogsEnabled(true);
    offerings = await Purchases.getOfferings();
    purchaserInfo = await Purchases.getPurchaserInfo();
    // String appUserID = await Purchases.appUserID;
    (purchaserInfo.entitlements.all[kEntitlementID] != null && purchaserInfo.entitlements.all[kEntitlementID]!.isActive) ? isEntitlementActivated = true : isEntitlementActivated = false;
    logger.w('offerings: $offerings');
    logger.w('purchaserInfo: $purchaserInfo');
    iState++;
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
