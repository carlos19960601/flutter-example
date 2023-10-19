import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/localization/translation_keys.dart' as translation;
import 'package:paisa/pages/on_boarding/view.dart';
import 'package:paisa/utils/storage.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  Box setting = GStorage.setting;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translation.appTitle.tr,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            Text(
              translation.introTitle.tr,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    translation.intoSummary1.tr,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    translation.intoSummary2.tr,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    translation.intoSummary3.tr,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(
                '*This app still in beta, expect the unexpected behavior and UI changes',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24),
          child: ElevatedButton(
            onPressed: () {
              setting.put(SettingBoxKey.userIntroShown, true);
              Get.off(() => const UserOnboardingPage());
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: Text(
              translation.introCTA.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
