import 'package:apidash/pages/dashboard/controller.dart';
import 'package:apidash/pages/home/view.dart';
import 'package:apidash/pages/intro/view.dart';
import 'package:apidash/pages/settings/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardController _dashboardController =
      Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Column(
              children: [
                const SizedBox(
                  width: 64,
                  height: 32,
                ),
                Column(
                  children: [
                    Obx(
                      () => IconButton(
                        onPressed: () {
                          _dashboardController.railIdx.value = 0;
                        },
                        isSelected: _dashboardController.railIdx.value == 0,
                        icon: const Icon(
                          Icons.auto_awesome_mosaic_outlined,
                        ),
                        selectedIcon: const Icon(Icons.auto_awesome_mosaic),
                      ),
                    ),
                    Text(
                      "Requests",
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Obx(
                          () => buttomButton(
                            context,
                            _dashboardController.railIdx.value,
                            1,
                            Icons.help,
                            Icons.help_outline,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Obx(
                          () => buttomButton(
                            context,
                            _dashboardController.railIdx.value,
                            2,
                            Icons.settings,
                            Icons.settings_outlined,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            VerticalDivider(
              thickness: 1,
              width: 1,
              color: Theme.of(context).colorScheme.surfaceVariant,
            ),
            Expanded(
              child: Obx(
                () => IndexedStack(
                  index: _dashboardController.railIdx.value,
                  children: const [
                    HomePage(),
                    IntroPage(),
                    SettingsPage(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextButton buttomButton(
    BuildContext context,
    int railIdx,
    int buttonIdx,
    IconData selectedIcon,
    IconData icon,
  ) {
    bool isSelected = railIdx == buttonIdx;
    return TextButton(
      style: isSelected
          ? TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            )
          : null,
      onPressed: () {
        _dashboardController.railIdx.value = buttonIdx;
      },
      child: Icon(
        isSelected ? selectedIcon : icon,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
