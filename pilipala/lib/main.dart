import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:media_kit/media_kit.dart';
import 'package:pilipala/common/widgets/custom_toast.dart';
import 'package:pilipala/http/init.dart';
import 'package:pilipala/models/common/color_type.dart';
import 'package:pilipala/models/common/theme_type.dart';
import 'package:pilipala/pages/main/view.dart';
import 'package:pilipala/pages/video/detail/view.dart';
import 'package:pilipala/router/app_pages.dart';
import 'package:pilipala/utils/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  // [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
  // .then((value) async {
  await GStorage.init();
  Request();
  await Request.setCookie();
  runApp(const MyApp());
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Box setting = GStorage.setting;
    Color defaultColor =
        colorThemeTypes[setting.get(SettingBoxKey.customColor, defaultValue: 0)]
            ['color'];
    Color brandColor = defaultColor;

    // 主题模式
    ThemeType currentThemeValue = ThemeType.values[setting
        .get(SettingBoxKey.themeMode, defaultValue: ThemeType.system.code)];

    // 是否动态取色
    bool isDynamicColor =
        setting.get(SettingBoxKey.dynamicColor, defaultValue: true);
    double textScale =
        setting.get(SettingBoxKey.defaultTextScale, defaultValue: 1.0);

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme? lightColorScheme;
        ColorScheme? darkColorScheme;
        if (lightDynamic != null && darkDynamic != null) {
          // dynamic 取色成功
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          // dynamic取色失败, 采用品牌色
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: brandColor,
            brightness: Brightness.light,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: brandColor,
            brightness: Brightness.dark,
          );
        }

        return GetMaterialApp(
          title: "PiLiPaLa",
          theme: ThemeData(
            colorScheme: currentThemeValue == ThemeType.dark
                ? darkColorScheme
                : lightColorScheme,
            useMaterial3: true,
            snackBarTheme: const SnackBarThemeData(),
            pageTransitionsTheme: const PageTransitionsTheme(),
          ),
          darkTheme: ThemeData(
            colorScheme: currentThemeValue == ThemeType.light
                ? lightColorScheme
                : darkColorScheme,
            useMaterial3: true,
            snackBarTheme: const SnackBarThemeData(),
            pageTransitionsTheme: const PageTransitionsTheme(),
          ),
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: const Locale("zh", "CN"),
          supportedLocales: const [Locale("zh", "CN"), Locale("en", "US")],
          fallbackLocale: const Locale("zh", "CN"),
          getPages: Routes.getPages,
          home: const MainApp(),
          builder: (BuildContext context, Widget? child) {
            return FlutterSmartDialog(
              toastBuilder: (msg) => CustomToast(msg: msg),
              child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.linear(textScale)),
                child: child!,
              ),
            );
          },
          navigatorObservers: [
            VideoDetailPage.routeObserver,
          ],
        );
      },
    );
  }
}
