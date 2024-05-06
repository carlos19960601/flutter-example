import 'dart:async';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final StreamController<bool> searchBarStream =
      StreamController<bool>.broadcast();
}
