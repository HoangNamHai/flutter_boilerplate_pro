import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

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

dynamic showSlidingSheet(Widget content, {List<double> snap = const [1.0]}) async {
  final result = await showSlidingBottomSheet(
    Get.context!,
    builder: (ctx) {
      return SlidingSheetDialog(
          duration: const Duration(milliseconds: 150),
          elevation: 8,
          cornerRadius: 16,
          snapSpec: SnapSpec(
            snap: true,
            snappings: snap,
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (ctx, state) {
            return Material(
              child: content,
            );
          });
    },
  );
  return result;
}
