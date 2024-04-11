import 'package:blackhole/pages/auth/view.dart';
import 'package:blackhole/pages/pref/view.dart';
import 'package:get/get.dart';

class Routes {
  static final List<GetPage> getPages = [
    GetPage(name: "/auth", page: () => const AuthPage()),
    GetPage(name: "/pref", page: () => const PrefPage())
  ];
}
