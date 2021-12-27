import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/app_controller.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/utils/consts.dart';
import 'package:flutter_app/utils/in_app_purchases_config.dart';
import 'package:flutter_app/utils/styles.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionDialog extends StatefulWidget {
  SubscriptionDialog({Key? key}) : super(key: key);

  @override
  SubscriptionDialogState createState() => SubscriptionDialogState();
}

class SubscriptionDialogState extends State<SubscriptionDialog> {
  AppController appController = Get.find<AppController>();
  Package? selectedPackage;

  Widget buildNoOfferPanel() {
    return Center(
      child: 'No offering available at the moment'.h5(),
    );
  }

  Widget buildPackageInfo(Package package) {
    bool isSelected = (package == selectedPackage);
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          side: isSelected ? BorderSide(color: kcYellow, width: 3) : BorderSide(color: Colors.white30, width: 1),
          borderRadius: BorderRadius.circular(kButtonBorderRadius),
        ),
        child: Container(
          constraints: BoxConstraints(minHeight: 120),
          child: Column(
            children: [
              SizedBox(height: 8),
              kProductsInfo[package.product.identifier]!.name.h4(),
              package.product.priceString.body(),
              kProductsInfo[package.product.identifier]!.tag == ''
                  ? Container()
                  : Chip(
                      backgroundColor: kcBlue,
                      label: Text(
                        kProductsInfo[package.product.identifier]!.tag,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
            ],
          ),
        ),
      ).gestures(
        onTap: () {
          setState(() {
            selectedPackage = package;
          });
        },
      ),
    );
  }

  List<Widget> buildOffersPanel() {
    if (appController.offerings == null) return [buildNoOfferPanel()];
    List<Widget> info = [];
    logger.w(appController.offerings);
    appController.offerings.current.availablePackages.forEach((Package package) {
      if (selectedPackage == null) selectedPackage = package;
      info.add(buildPackageInfo(package));
    });
    return info;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildTitleBar(),
            buildPremiumAccessTile(),
            buildBasicAccessTile(),
            buildFooter(),
          ],
        ).paddingOnly(left: 16, right: 16),
      ),
    );
  }

  Card buildBasicAccessTile() {
    return Card(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 120),
        child: Column(
          children: [
            'Basic access'.h5(),
            SizedBox(height: 8),
            kBasicInfo.body(),
            'Continue basic access'.button(() {
              Get.back();
            }),
            SizedBox(height: 8),
          ],
        ),
      ).paddingAll(8),
    );
  }

  Card buildPremiumAccessTile() {
    return Card(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 120),
        child: Column(
          children: [
            'Premium access'.h5(),
            SizedBox(height: 8),
            kBasicInfo.body(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildOffersPanel(),
            ),
            'Subscribe now'.button(() async {
              logger.v('💰 Subcribe package: $selectedPackage');
              try {
                PurchaserInfo info = await appController.purchase(selectedPackage);
                logger.v('💰 Purchase info: $info');
                Get.back();
              } catch (e) {
                logger.e('Purchase error: $e');
              }
            }),
            SizedBox(height: 8),
          ],
        ),
      ).paddingAll(8),
    );
  }

  Row buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        'Term of service'.caption().gestures(onTap: () => launch(kUrlTermsOfService)),
        ' | Privacy policy'.caption().gestures(onTap: () => launch(kUrlPrivacyPolicy)),
        ' | Restore purchases'.caption().gestures(onTap: () => appController.restorePurchase()),
      ],
    );
  }

  Widget buildTitleBar() {
    return Container(
      height: 48,
      child: Stack(
        children: [
          Center(
            child: 'Subscription'.h4(),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: Icon(
              Icons.close,
              size: 24,
              color: Colors.grey,
            ).paddingOnly(bottom: 12).gestures(onTap: () => Get.back()),
          ),
        ],
      ),
    );
  }
}
