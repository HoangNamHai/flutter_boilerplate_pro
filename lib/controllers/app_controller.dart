import 'package:flutter_app/utils/utils.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:package_info_plus/package_info_plus.dart';

var logger = getLogger('AppController');

class AppController extends GetxController {
  late final PackageInfo packageInfo;

  @override
  Future<void> onInit() async {
    super.onInit();
    packageInfo = await PackageInfo.fromPlatform();
    logger.i(packageInfo);
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
