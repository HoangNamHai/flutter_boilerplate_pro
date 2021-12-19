import 'package:flutter/material.dart';
import 'package:flutter_app/screens/homepage/homepage_view1.dart';
import 'package:flutter_app/screens/homepage/homepage_profile_view.dart';
import 'package:flutter_app/screens/homepage/homepage_view2.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/utils/custom_printer.dart';
import 'package:flutter_app/utils/styles.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: CustomPrinter('HomePageScreen'),
);

class HomePageScreen extends StatefulWidget {
  static String tag = '/homepage';

  HomePageScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _counter = 0;
  int selectedIndex = 0;
  List navViews = [
    HomepageView1(),
    HomepageView2(),
    HomepageProfileView(),
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    logger.v("Counter: $_counter");
    logger.v("Verbose log");
    logger.d("Debug log");
    logger.i("Info log");
    logger.w("Warning log");
    logger.e("Error log");
    logger.wtf("What a terrible failure log");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: navViews[selectedIndex],
      bottomNavigationBar: buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: kcBgNavBar,
      selectedLabelStyle: ksBody.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
      selectedItemColor: kcPrimary,
      unselectedLabelStyle: ksBody.copyWith(fontSize: 12),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.auto_graph_outlined), label: 'View 1'),
        BottomNavigationBarItem(icon: Icon(Icons.checklist_rounded), label: 'View 2'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
      ],
      currentIndex: selectedIndex,
      // fixedColor: Colors.deepPurple,
      onTap: (int idx) {
        setState(() {
          selectedIndex = idx;
        });
      },
    );
  }
}
