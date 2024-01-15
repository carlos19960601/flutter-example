import 'package:flutter/material.dart';
import 'package:flutter_whirlpool/pages/main/widgets/top_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: SafeArea(child: TopBar()),
      ),
    );
  }
}
