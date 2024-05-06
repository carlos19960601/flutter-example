import 'package:flutter/material.dart';
import 'package:taobao/core/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget v = const Column(
      children: [
        _buildHotSearchWidget(context),
      ],
    );

    return Scaffold(
      backgroundColor: AppColor.mainBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          Offstage(
            offstage: true,
            child: Container(
              child: v,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotSearchWidget(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: const Row(
        children: [SizedBox(width: 10), Text("热搜")],
      ),
    );
  }
}
