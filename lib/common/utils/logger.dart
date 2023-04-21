import 'package:logger/logger.dart';

class CommonLogger {
  CommonLogger._();
  static final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      printTime: true,
      printEmojis: false,
    ),
  );
  static void debug(String message) {
    logger.d(message);
  }

  static void info(String message) {
    logger.i(message);
  }

  static void error(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    logger.e(message, error, stackTrace);
  }
}
