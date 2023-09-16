import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/pages/home/controller.dart';
import 'package:pilipala/pages/mine/view.dart';
import 'package:pilipala/pages/search/view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());
  showUserBottonSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => const SizedBox(
        height: 450,
        child: MinePage(),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            callback: showUserBottonSheet,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: TabBar(
              controller: _homeController.tabController,
              tabs: [for (var i in _homeController.tabs) Tab(text: i["label"])],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _homeController.tabController,
              children: _homeController.tabsPageList,
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}

class CustomAppBar extends StatelessWidget {
  final Function? callback;
  const CustomAppBar({super.key, this.callback});

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
          SizedBox(
            width: 38,
            height: 38,
            child: IconButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => Theme.of(context).colorScheme.onInverseSurface,
                ),
              ),
              onPressed: () => callback!(),
              icon: Icon(
                Icons.person_rounded,
                size: 22,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
