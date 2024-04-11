import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
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
        shadowColor: AppColors.shadowColor,
        appBarTheme: const AppBarTheme(
          toolbarHeight: kToolbarHeight,
          backgroundColor: AppColors.cardColor,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              color: AppColors.headline1Color,
              fontSize: 13,
              fontWeight: FontWeight.w500),
          displayMedium: TextStyle(
              color: AppColors.headline1Color,
              fontSize: 15,
              fontWeight: FontWeight.w500),
          titleMedium: TextStyle(
              color: AppColors.headline4Color,
              fontSize: 17,
              fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(
              color: AppColors.body1TxtColor,
              fontSize: 13,
              fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(
              color: AppColors.body2TxtColor,
              fontSize: 16,
              fontWeight: FontWeight.normal),
          titleSmall: TextStyle(
            color: AppColors.headline4Color,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(AuthService());
        Get.put(PlayerService());
      }),
      initialRoute: Routes.SPLASH,
      getPages: AppPages.routes,
      builder: DevicePreview.appBuilder,
    );
  }
}
