import 'package:logger/logger.dart';

class Log {
  static final Log _instance = Log._();
  static late final Logger logger;
  factory Log() => _instance;

  Log._() {
    logger = Logger();
  }

  info(dynamic message) {
    logger.i(message);
  }

  error(dynamic message, Object error) {
    logger.e(message, error: error);
  }
}
