import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../utils/custom_printer.dart';
import './hello_america_screen_controller.dart';

var logger = Logger(
  printer: CustomPrinter('HelloAmericaScreen'),
);

class HelloAmericaScreen extends StatefulWidget {
  HelloAmericaScreen({Key? key}) : super(key: key);

  @override
  _HelloAmericaScreen createState() => _HelloAmericaScreen();
}

class _HelloAmericaScreen extends State<HelloAmericaScreen> {
  final HelloAmericaController helloAmericaController = Get.put(HelloAmericaController());

  @override
  void initState() {
    logger.v("HelloAmericaScreen init");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Hello America Screen'),
      ),
    );
  }
}
