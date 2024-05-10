import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/core/app_extensions.dart';
import 'package:paisa/core/app_storage.dart';
import 'package:paisa/localization/localization_keys.dart';
import 'package:paisa/pages/intro/widgets/intro_text.dart';
import 'package:paisa/routes/app_routes.dart';
import 'package:paisa/widgets/paisa_button.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  Box setting = AppStorage.setting;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocalizationKeys.appTitle.tr,
                style: context.displaySmall?.copyWith(color: context.primary)),
            Text(
              LocalizationKeys.introTitle.tr,
              style: context.headlineSmall?.copyWith(color: context.secondary),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                IntroTextWidget(
                  title: LocalizationKeys.intoSummary1.tr,
                ),
                IntroTextWidget(
                  title: LocalizationKeys.intoSummary2.tr,
                ),
                IntroTextWidget(
                  title: LocalizationKeys.intoSummary3.tr,
                ),
              ],
            ),
            const Spacer(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(
                '*This app still in beta, expect the unexpected behavior and UI changes',
                style: context.titleSmall?.copyWith(
                  color: context.bodySmall?.color,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24),
          child: PaisaBigButton(
            onPressed: () {
              setting.put(SettingBoxKey.userIntroShown, true);
              Get.toNamed(AppRoutes.onboarding);
            },
            title: LocalizationKeys.introCTA.tr,
          ),
        ),
      ),
    );
  }
}
