import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/custom_printer.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

Flushbar<dynamic> alert({String msg = 'Hello', IconData icon = Icons.info_outline, Color color = Colors.red, int duration = 200, Color backgroundColor = Colors.black}) {
  return Flushbar(
    message: msg,
    icon: Icon(
      icon,
      size: 28.0,
      color: color,
    ),
    duration: Duration(seconds: 3),
    leftBarIndicatorColor: color,
    animationDuration: Duration(milliseconds: duration),
    backgroundColor: backgroundColor,
  )..show(Get.context!);
}

Logger getLogger(String name) {
  return Logger(
    printer: CustomPrinter(name),
  );
}
