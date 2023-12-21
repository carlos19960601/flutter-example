import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:pilipala/common/widgets/custom_toast.dart';
import 'package:pilipala/http/init.dart';
import 'package:pilipala/models/common/color_type.dart';
import 'package:pilipala/pages/main/view.dart';
import 'package:pilipala/pages/video/detail/view.dart';
import 'package:pilipala/router/app_pages.dart';
import 'package:pilipala/utils/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) async {
    await GStorage.init();
    runApp(const MyApp());
    await Request().setCookie();
    GStorage.lazyInit();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color defaultColor = colorThemeTypes[0]['color'];
    Color brandColor = defaultColor;

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme? lightColorScheme;
        ColorScheme? darkColorScheme;
        if (lightDynamic != null && darkDynamic != null) {
        } else {
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
            colorScheme: lightColorScheme,
          ),
          getPages: Routes.getPages,
          home: const MainApp(),
          locale: const Locale("zh", "CN"),
          builder: (BuildContext context, Widget? child) {
            return FlutterSmartDialog(
              toastBuilder: (msg) => CustomToast(msg: msg),
              child: child!,
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
