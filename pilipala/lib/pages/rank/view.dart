import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/pages/rank/controller.dart';
import 'package:pilipala/utils/feed_back.dart';

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  final RankController _rankController = Get.put(RankController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: false,
      appBar: _rankController.enableGradientBg
          ? null
          : AppBar(toolbarHeight: 0, elevation: 0),
      body: Stack(
        children: [
          // gradient background
          if (_rankController.enableGradientBg) ...[
            Align(
              alignment: Alignment.topLeft,
              child: Opacity(
                opacity: 0.6,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.9),
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                          Theme.of(context).colorScheme.surface
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [0, 0.0034, 0.34]),
                  ),
                ),
              ),
            ),
          ],
          Column(
            children: [
              const CustomAppBar(),
              if (_rankController.tabs.length > 1) ...[
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: Align(
                    alignment: Alignment.center,
                    child: TabBar(
                      controller: _rankController.tabController,
                      tabs: [
                        for (var i in _rankController.tabs)
                          Tab(text: i['label'])
                      ],
                      isScrollable: true,
                      dividerColor: Colors.transparent,
                      enableFeedback: true,
                      splashBorderRadius: BorderRadius.circular(10),
                      tabAlignment: TabAlignment.center,
                      onTap: (value) {
                        feedback();
                        if (_rankController.initialIndex.value == value) {
                          _rankController.tabsCtrList[value]().animateToTop();
                        }
                        _rankController.initialIndex.value = value;
                      },
                    ),
                  ),
                ),
              ] else ...[
                const SizedBox(height: 6),
              ],
              Expanded(
                child: TabBarView(
                  controller: _rankController.tabController,
                  children: _rankController.tabsPageList,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({
    super.key,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final double top = MediaQuery.of(context).padding.top;
    return Container(
      width: Get.mediaQuery.size.width,
      height: top,
      color: Colors.transparent,
    );
  }
}
