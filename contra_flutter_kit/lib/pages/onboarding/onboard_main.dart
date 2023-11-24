import 'package:flutter/material.dart';

class OnboardPageMain extends StatefulWidget {
  const OnboardPageMain({super.key});

  @override
  State<OnboardPageMain> createState() => _OnboardPageMainState();
}

class _OnboardPageMainState extends State<OnboardPageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Onboarding"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              trailing: const Icon(Icons.navigate_next),
              title: const Text("Type One"),
              onTap: () {
                Navigator.pushNamed(context, "/onboard_type_one");
              },
            ),
            ListTile(
              trailing: const Icon(Icons.navigate_next),
              title: const Text("Type Two"),
              onTap: () {
                Navigator.pushNamed(context, "/onboard_type_two");
              },
            ),
            ListTile(
              trailing: const Icon(Icons.navigate_next),
              title: const Text("Type Three"),
              onTap: () {
                Navigator.pushNamed(context, "/onboard_type_three");
              },
            ),
            ListTile(
              trailing: const Icon(Icons.navigate_next),
              title: const Text("Type Four"),
              onTap: () {
                Navigator.pushNamed(context, "/onboard_type_four");
              },
            ),
          ],
        ),
      ),
    );
  }
}
