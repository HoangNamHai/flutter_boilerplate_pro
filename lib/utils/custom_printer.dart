import 'package:logger/logger.dart';

const levelEmojis = {
  Level.verbose: '',
  Level.debug: '🐛 ',
  Level.info: '🟢 ',
  Level.warning: '🟡',
  Level.error: '⛔ ',
  Level.wtf: '🆘',
};

class CustomPrinter extends LogPrinter {
  final String className;
  CustomPrinter(this.className);
  List<String> log(LogEvent event) {
    final emoji = levelEmojis[event.level];
    final message = event.message;
    return [('$className: $emoji: $message')];
  }
}
