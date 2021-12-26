import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/app_controller.dart';
import 'package:flutter_app/dialogs/subscription_dialog.dart';
import 'package:flutter_app/utils/consts.dart';
import 'package:flutter_app/utils/styles.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomepageProfileView extends StatefulWidget {
  HomepageProfileView({Key? key}) : super(key: key);

  @override
  _HomepageProfileViewState createState() => _HomepageProfileViewState();
}

class _HomepageProfileViewState extends State<HomepageProfileView> {
  AppController appController = Get.find<AppController>();
  Widget buildAccountTile() {
    if (appController.user == null) return Container();
    return Column(
      children: [
        'Account'.headerTile(),
        'ID: ${appController.user?.uid}'.body(),
        'Creation at: ${appController.user?.metadata.creationTime}\n'.body(),
        Obx(() {
          // Reactive to enable or disable the subscribe button
          print(appController.iState.value);
          return appController.isEntitlementActivated
              ? Container()
              : 'Subcribe for premium access'.button(() {
                  showSlidingSheet(SubscriptionDialog());
                });
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildAccountTile(),
            'Help & Support'.headerTile(),
            ListTile(
              leading: Icon(MdiIcons.fromString('helpRhombusOutline'), size: 30),
              trailing: Icon(MdiIcons.fromString('chevronRight'), size: 24),
              title: Text('Help & Message Center').body(),
              onTap: () => launch(kUrlHelpCenter),
            ),
            ListTile(
              leading: Icon(MdiIcons.fromString('fileDocument'), size: 30),
              trailing: Icon(MdiIcons.fromString('chevronRight'), size: 24),
              title: Text('Terms of Service').body(),
              onTap: () => launch(kUrlTermsOfService),
            ),
            ListTile(
              leading: Icon(MdiIcons.fromString('accountCircleOutline'), size: 30),
              trailing: Icon(MdiIcons.fromString('chevronRight'), size: 24),
              title: Text('Privacy Policy').body(),
              onTap: () => launch(kUrlPrivacyPolicy),
            ),
          ],
        ),
      ),
    );
  }
}
