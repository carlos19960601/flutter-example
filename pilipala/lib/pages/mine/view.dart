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

  @override
  void initState() {
    super.initState();
    mineController.queryUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            onPressed: () {},
            icon: Icon(mineController.themeType.value == ThemeType.dark
                ? CupertinoIcons.sun_max
                : CupertinoIcons.moon),
          ),
          IconButton(
            onPressed: () => Get.toNamed('/setting'),
            icon: const Icon(
              CupertinoIcons.slider_horizontal_3,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              const SizedBox(height: 10),
              userInfoBuild(mineController, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget userInfoBuild(_mineController, context) {
    LevelInfo levelInfo = _mineController.userInfo.value.levelInfo;
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () => _mineController.onLogin(),
          child: ClipOval(
            child: Container(
              width: 85,
              height: 85,
              color: Theme.of(context).colorScheme.onInverseSurface,
              child: Center(
                child: _mineController.userInfo.value.face != null
                    ? NetworkImgLayer(
                        src: _mineController.userInfo.value.face,
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
              _mineController.userInfo.value.uname ?? "点击头像登录",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 4),
            Image.asset(
              'assets/images/lv/lv${_mineController.userInfo.value.levelInfo != null ? _mineController.userInfo.value.levelInfo!.currentLevel : '0'}.png',
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
                    text: (_mineController.userInfo.value.money ?? 'pilipala')
                        .toString(),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
              ],
            ))
          ],
        ),
        const SizedBox(height: 25),
        // 等级
        if (_mineController.userInfo.value.levelInfo != null) ...[
          SizedBox(
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
                    child: Text(
                      '${levelInfo.currentExp}/${levelInfo.nextExp}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
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
                            (_mineController.userStat.value.dynamicCount ?? '-')
                                .toString(),
                            key: ValueKey<String>(_mineController
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
                            (_mineController.userStat.value.following ?? '-')
                                .toString(),
                            key: ValueKey(_mineController
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
                            (_mineController.userStat.value.follower ?? '-')
                                .toString(),
                            key: ValueKey(_mineController
                                .userStat.value.follower
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
