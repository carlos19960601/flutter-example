import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_templates/pages/navigation/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    return MaterialApp(
      title: 'Flutter UI',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        platform: TargetPlatform.iOS,
      ),
      home: const NavigationHomePage(),
    );
  }
}
