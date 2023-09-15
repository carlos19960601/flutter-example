import 'package:flutter/material.dart';
import 'package:pilipala/pages/search/view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: Center(
              child: Text("TabBar1"),
            ),
          ),
          // Expanded(
          //   child: TabBarView(
          //     children: [],
          //   ),
          // )
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 0,
        top: MediaQuery.of(context).padding.top + 4,
      ),
      child: Row(
        children: [
          const Expanded(
            child: SearchPage(),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
