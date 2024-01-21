import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/routes/app_pages.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      theme: ThemeData(
        colorSchemeSeed: AppColors.appMain,
        scaffoldBackgroundColor: AppColors.bgColor,
        cardColor: AppColors.cardColor,
        appBarTheme: const AppBarTheme(
          toolbarHeight: kToolbarHeight,
          backgroundColor: AppColors.cardColor,
        ),
        textTheme: const TextTheme(
          titleSmall: TextStyle(
            color: AppColors.headline4Color,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(AuthService());
      }),
      initialRoute: Routes.SPLASH,
      getPages: AppPages.routes,
      builder: DevicePreview.appBuilder,
    );
  }
}
