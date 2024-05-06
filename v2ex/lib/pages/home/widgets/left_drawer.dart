import 'package:flutter/material.dart';

class HomeLeftDrawer extends StatefulWidget {
  const HomeLeftDrawer({super.key});

  @override
  State<HomeLeftDrawer> createState() => _HomeLeftDrawerState();
}

class _HomeLeftDrawerState extends State<HomeLeftDrawer> {
  @override
  Widget build(BuildContext context) {
    final drawerItems = [
      Container(
        padding: const EdgeInsets.only(top: 15, left: 35, bottom: 15),
        child: Text(
          "V2EX",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
        ),
      ),
    ];

    return NavigationDrawer(children: drawerItems);
  }
}
