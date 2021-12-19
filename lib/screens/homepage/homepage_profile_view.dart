import 'package:flutter/material.dart';
import 'package:flutter_app/utils/consts.dart';
import 'package:flutter_app/utils/styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomepageProfileView extends StatefulWidget {
  HomepageProfileView({Key? key}) : super(key: key);

  @override
  _HomepageProfileViewState createState() => _HomepageProfileViewState();
}

class _HomepageProfileViewState extends State<HomepageProfileView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          'Profile View'.h1(),
          'Profile View'.headerTile(),
          ListTile(
            leading: Icon(MdiIcons.helpRhombusOutline, size: 30),
            trailing: Icon(Icons.chevron_right),
            title: Text('Help & Message Center').body(),
            onTap: () => launch(kUrlHelpCenter),
          ),
          ListTile(
            leading: Icon(MdiIcons.fileDocument, size: 30),
            trailing: Icon(Icons.chevron_right),
            title: Text('Terms of Service').body(),
            onTap: () => launch(kUrlTermsOfService),
          ),
          ListTile(
            leading: Icon(MdiIcons.accountCircleOutline, size: 30),
            trailing: Icon(Icons.chevron_right),
            title: Text('Privacy Policy').body(),
            onTap: () => launch(kUrlPrivacyPolicy),
          ),
        ],
      ),
    );
  }
}
