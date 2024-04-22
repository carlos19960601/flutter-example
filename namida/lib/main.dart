import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:namida/core/app_logger.dart';
import 'package:namida/core/app_theme.dart';

void main() {
  runZonedGuarded(mainInitialization, (error, stack) {
    logger.error(error.runtimeType, e: error, st: stack);
  });
}

void mainInitialization() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool shouldShowOnBoarding = false;

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (BuildContext context) =>
        Namida(shouldShowOnBoarding: shouldShowOnBoarding),
  ));
}

class Namida extends StatelessWidget {
  const Namida({
    super.key,
    required this.shouldShowOnBoarding,
  });

  final bool shouldShowOnBoarding;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Namida',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        return AnimatedTheme(
          data: ThemeData(),
          child: child!,
        );
      },
      home: ,
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
