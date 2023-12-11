import 'package:cashew/pages/navigation_framework/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class PageNavigationFramework extends StatefulWidget {
  const PageNavigationFramework({super.key});

  @override
  State<PageNavigationFramework> createState() =>
      PageNavigationFrameworkState();
}

class PageNavigationFrameworkState extends State<PageNavigationFramework> {
  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Scaffold(
          bottomNavigationBar: BottomNavBar(),
        ),
      ],
    );
  }
}
