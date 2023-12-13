import 'package:uuid/uuid.dart';

class UUID {
  static const Uuid uuid = Uuid();

  static String v1() {
    return uuid.v1();
  }
}
