import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Flushbar<dynamic> alert(
    {String msg = 'Hello',
    IconData icon = Icons.info_outline,
    Color color = Colors.red,
    int duration = 200,
    Color backgroundColor = Colors.black45}) {
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
