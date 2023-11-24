import 'package:contra_flutter_kit/router/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Contra',
      getPages: Routes.getPages,
      theme: ThemeData(
        fontFamily: "Montserrat",
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1947E6)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Contra设计'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                title: const Text("Onboarding and Splash"),
                trailing: const Icon(Icons.navigate_next),
                onTap: () => Get.toNamed("/onboard_all"),
              ),
              ListTile(
                title: const Text("Forms, Login, Signup"),
                trailing: const Icon(Icons.navigate_next),
                onTap: () => Get.toNamed("/login_all"),
              ),
              ListTile(
                title: const Text("Chatting Screens"),
                trailing: const Icon(Icons.navigate_next),
                onTap: () => Get.toNamed("/chat_home"),
              ),
              ListTile(
                title: const Text("Shopping Screens"),
                trailing: const Icon(Icons.navigate_next),
                onTap: () => Get.toNamed("/shopping_main_page"),
              ),
              ListTile(
                title: const Text("Blog Screens"),
                trailing: const Icon(Icons.navigate_next),
                onTap: () => Get.toNamed("/blog_main_page"),
              ),
              ListTile(
                title: const Text("Payment"),
                trailing: const Icon(Icons.navigate_next),
                onTap: () => Get.toNamed("/payment_main_page"),
              ),
              ListTile(
                title: const Text("Alarm, Clock, Weather"),
                trailing: const Icon(Icons.navigate_next),
                onTap: () => Get.toNamed("/alarm_main_page"),
              ),
              ListTile(
                title: const Text("Content, Text Details"),
                trailing: const Icon(Icons.navigate_next),
                onTap: () => Get.toNamed("/map_main_page"),
              ),
              ListTile(
                title: const Text("Menu and Settings"),
                trailing: const Icon(Icons.navigate_next),
                onTap: () => Get.toNamed("/menu_settings_main_page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
