import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../utils/custom_printer.dart';

var logger = Logger(
  printer: CustomPrinter('AppIntroScreenController'),
);

class AppIntroController extends GetxController {
  
  @override
  void onInit() {
    logger.v('AppIntroScreenController onInit');
    super.onInit();
  }

  @override
  void onReady() {
  }

  @override
  void onClose() {
  }
}
