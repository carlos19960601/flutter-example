import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ui_templates/common/app_theme.dart';
import 'package:ui_templates/models/homelist.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool multiple = true;
  List<HomeList> homeList = HomeList.homeList;

  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            appBar(),
            Expanded(
              child: GridView(
                padding: const EdgeInsets.only(left: 12, right: 12),
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: multiple ? 2 : 1,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
                  childAspectRatio: 1.5,
                ),
                children: List<Widget>.generate(homeList.length, (index) {
                  final int count = homeList.length;
                  // 主要是用Interval来实现延时效果
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0)));
                  animationController?.forward();
                  return HomeListView(
                    animation: animation,
                    animationController: animationController,
                    listData: homeList[index],
                    callBack: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              homeList[index].navigateScreen!,
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: SizedBox(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          const Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  'Flutter UI',
                  style: TextStyle(
                    fontSize: 22,
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: InkWell(
              child: Icon(
                multiple ? Icons.dashboard : Icons.view_agenda,
                color: AppTheme.darkGrey,
              ),
              onTap: () {
                setState(() {
                  multiple = !multiple;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView({
    super.key,
    this.listData,
    this.callBack,
    this.animationController,
    this.animation,
  });

  final HomeList? listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform:
                Matrix4.translationValues(0, 50 * (1.0 - animation!.value), 0),
            child: child,
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 1.5,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned.fill(
                child: Image.asset(
                  listData!.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  onTap: callBack,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
