import 'package:flutter/material.dart';

class LoginMainPage extends StatefulWidget {
  const LoginMainPage({super.key});

  @override
  State<LoginMainPage> createState() => _LoginMainPageState();
}

class _LoginMainPageState extends State<LoginMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              trailing: const Icon(Icons.navigate_next),
              title: const Text("Type One"),
              onTap: () {
                Navigator.pushNamed(context, "/login_type_one");
              },
            ),
            ListTile(
              trailing: const Icon(Icons.navigate_next),
              title: const Text("Type Two"),
              onTap: () {
                Navigator.pushNamed(context, "/login_type_two");
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
                Navigator.pushNamed(context, "/login_type_four");
              },
            ),
            ListTile(
              trailing: const Icon(Icons.navigate_next),
              title: const Text("Type Verification"),
              onTap: () {
                Navigator.pushNamed(context, "/login__type_verification");
              },
            ),
            ListTile(
              trailing: const Icon(Icons.navigate_next),
              title: const Text("Type Signup"),
              onTap: () {
                Navigator.pushNamed(context, "/signin_type_one");
              },
            ),
            ListTile(
              trailing: const Icon(Icons.navigate_next),
              title: const Text("Contact Us Form"),
              onTap: () {
                Navigator.pushNamed(context, "/contact_us_form");
              },
            ),
          ],
        ),
      ),
    );
  }
}
