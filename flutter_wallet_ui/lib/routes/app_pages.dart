import 'package:flutter_wallet_ui/pages/overview/view.dart';
import 'package:flutter_wallet_ui/routes/appp_routes.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(name: AppRoutes.overview, page: () => const OverviewPage()),
  ];
}
