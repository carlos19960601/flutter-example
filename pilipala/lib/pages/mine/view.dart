import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/common/constants.dart';
import 'package:pilipala/common/widgets/network_img_layer.dart';
import 'package:pilipala/models/common/theme_type.dart';
import 'package:pilipala/models/user/info.dart';
import 'package:pilipala/pages/mine/controller.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  final MineController mineController = Get.put(MineController());
  late Future _futureBuilderFuture;

  @override
  void initState() {
    super.initState();
    _futureBuilderFuture = mineController.queryUserInfo();

    mineController.userLogin.listen((status) {
      if (mounted) {
        setState(() {
          _futureBuilderFuture = mineController.queryUserInfo();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        elevation: 0,
        toolbarHeight: kTextTabBarHeight + 20,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          "PLPL",
          style: TextStyle(
            height: 2.8,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            fontFamily: "Jura-Bold",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => mineController.onChangeTheme(),
            icon: Icon(mineController.themeType.value == ThemeType.dark
                ? CupertinoIcons.sun_max
                : CupertinoIcons.moon),
          ),
          IconButton(
            onPressed: () => Get.toNamed('/setting', preventDuplicates: false),
            icon: const Icon(
              CupertinoIcons.slider_horizontal_3,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: constraint.maxHeight,
            child: Column(
              children: [
                const SizedBox(height: 10),
                FutureBuilder(
                  future: _futureBuilderFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == null) {
                        return const SizedBox();
                      }
                      if (snapshot.data["status"]) {
                        return Obx(
                            () => userInfoBuild(mineController, context));
                      } else {
                        return userInfoBuild(mineController, context);
                      }
                    }
                    return userInfoBuild(mineController, context);
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget userInfoBuild(MineController mineController, BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () => mineController.onLogin(),
          child: ClipOval(
            child: Container(
              width: 85,
              height: 85,
              color: Theme.of(context).colorScheme.onInverseSurface,
              child: Center(
                child: mineController.userInfo.value.face != null
                    ? NetworkImgLayer(
                        src: mineController.userInfo.value.face,
                        width: 85,
                        height: 85,
                      )
                    : Image.asset('assets/images/noface.jpeg'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mineController.userInfo.value.uname ?? "点击头像登录",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 4),
            Image.asset(
              'assets/images/lv/lv${mineController.userInfo.value.levelInfo != null ? mineController.userInfo.value.levelInfo!.currentLevel : '0'}.png',
              height: 10,
            ),
          ],
        ),
        const SizedBox(height: 5),
        // 硬币
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(TextSpan(
              children: [
                TextSpan(
                    text: '硬币: ',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.outline)),
                TextSpan(
                    text: (mineController.userInfo.value.money ?? 'pilipala')
                        .toString(),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
              ],
            ))
          ],
        ),
        const SizedBox(height: 25),
        // 等级
        if (mineController.userInfo.value.levelInfo != null) ...[
          LayoutBuilder(builder: (context, BoxConstraints constraints) {
            LevelInfo levelInfo = mineController.userInfo.value.levelInfo!;
            return SizedBox(
              width: constraints.maxWidth,
              height: 24,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: Theme.of(context).colorScheme.primary,
                      height: 24,
                      constraints: const BoxConstraints(minWidth: 100),
                      width: constraints.maxWidth *
                          (1 - (levelInfo.currentExp! / levelInfo.nextExp!)),
                      child: Center(
                        child: Text(
                          '${levelInfo.currentExp}/${levelInfo.nextExp}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 23,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      height: 1,
                      color: Theme.of(context).colorScheme.primary,
                      width: constraints.maxWidth *
                          (levelInfo.currentExp! / levelInfo.nextExp!),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: LayoutBuilder(builder: (context, constraints) {
            TextStyle style = TextStyle(
              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            );
            return SizedBox(
              height: constraints.maxWidth / 3 * 0.6,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(0),
                crossAxisCount: 3,
                childAspectRatio: 1.67,
                children: [
                  InkWell(
                    onTap: () {},
                    borderRadius: StyleString.mdRadius,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: Text(
                            (mineController.userStat.value.dynamicCount ?? '-')
                                .toString(),
                            key: ValueKey<String>(mineController
                                .userStat.value.following
                                .toString()),
                            style: style,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '动态',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed("/follow"),
                    borderRadius: StyleString.mdRadius,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: Text(
                            (mineController.userStat.value.following ?? '-')
                                .toString(),
                            key: ValueKey(mineController
                                .userStat.value.following
                                .toString()),
                            style: style,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '关注',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed('/fan'),
                    borderRadius: StyleString.mdRadius,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: Text(
                            (mineController.userStat.value.follower ?? '-')
                                .toString(),
                            key: ValueKey(mineController.userStat.value.follower
                                .toString()),
                            style: style,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '粉丝',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
