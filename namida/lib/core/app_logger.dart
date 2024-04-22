import 'package:logger/logger.dart';

final logger = AppLogger();

class AppLogger {
  late Logger _logger = updateLogger(Level.all);

  Logger updateLogger(Level? level) {
    return _logger = Logger(
      level: level,
      printer: PrettyPrinter(),
    );
  }

  void error(dynamic message, {Object? e, StackTrace? st}) {
    _logger.e(message, error: e, stackTrace: st);
  }
}
