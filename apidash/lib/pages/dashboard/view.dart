import 'package:apidash/pages/dashboard/controller.dart';
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
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.auto_awesome_mosaic_outlined,
                      ),
                      selectedIcon: const Icon(Icons.auto_awesome_mosaic),
                    ),
                    Text(
                      "Requests",
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Obx(() => buttomButton(
                              context,
                              _dashboardController.railIdx.value,
                              1,
                              Icons.help,
                              Icons.help_outline,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
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
        onPressed: () {}, child: Icon(isSelected ? selectedIcon : icon));
  }
}
