import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class SubscriptionDialog extends StatefulWidget {
  SubscriptionDialog({Key? key}) : super(key: key);

  @override
  SubscriptionDialogState createState() => SubscriptionDialogState();
}

class SubscriptionDialogState extends State<SubscriptionDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      child: Column(
        children: [
          buildTitleBar(),
          Text('Hello World'),
        ],
      ),
    );
  }

  Widget buildTitleBar() {
    return Container(
      height: 48,
      child: Stack(
        children: [
          Center(
            child: Text('Subscription Dialog', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
