import 'package:flutter/material.dart';
import 'package:flutter_app/utils/styles.dart';

class HomepageProfileView extends StatefulWidget {
  HomepageProfileView({Key? key}) : super(key: key);

  @override
  _HomepageProfileViewState createState() => _HomepageProfileViewState();
}

class _HomepageProfileViewState extends State<HomepageProfileView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: 'Profile View'.h1(),
    );
  }
}
