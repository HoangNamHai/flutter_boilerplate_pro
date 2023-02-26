import 'package:flutter_app/services/sqlite_service.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

var logger = getLogger('AppController');

class AppController extends GetxController {
  late final PackageInfo packageInfo;

  @override
  Future<void> onInit() async {
    super.onInit();
    packageInfo = await PackageInfo.fromPlatform();
    logger.i(packageInfo);
    await Get.putAsync(() => SqliteService().init());
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
