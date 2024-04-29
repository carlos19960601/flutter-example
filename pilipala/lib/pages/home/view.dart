import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/common/widgets/network_img_layer.dart';
import 'package:pilipala/pages/home/controller.dart';
import 'package:pilipala/pages/mine/view.dart';
import 'package:pilipala/utils/feed_back.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());
  late Stream<bool> stream;

  @override
  void initState() {
    super.initState();
    stream = _homeController.searchBarStream.stream;
  }

  @override
  void dispose() {
    _homeController.dispose();
    super.dispose();
  }

  showUserBottonSheet() {
    feedback();
    showModalBottomSheet(
      context: context,
      builder: (_) => const SizedBox(
        height: 450,
        child: MinePage(),
      ),
      clipBehavior: Clip.hardEdge,
      isScrollControlled: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: _homeController.enableGradientBg
          ? null
          : AppBar(toolbarHeight: 0, elevation: 0),
      body: Stack(
        children: [
          if (_homeController.enableGradientBg)
            Align(
              alignment: Alignment.topLeft,
              child: Opacity(
                opacity: 0.6,
                child: Container(
                  width: Get.mediaQuery.size.width,
                  height: Get.mediaQuery.size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.9),
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                        Theme.of(context).colorScheme.surface,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: const [
                        0,
                        0.0034,
                        0.34,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          Column(
            children: [
              CustomAppBar(
                stream: _homeController.hideSearchBar
                    ? stream
                    : StreamController<bool>.broadcast().stream,
                callback: showUserBottonSheet,
                ctr: _homeController,
              ),
              if (_homeController.tabs.length > 1) ...[
                if (_homeController.enableGradientBg) ...[
                  const CustomTabs(),
                ] else ...[
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 42,
                    child: Align(
                      alignment: Alignment.center,
                      child: TabBar(
                        controller: _homeController.tabController,
                        tabs: [
                          for (var i in _homeController.tabs)
                            Tab(text: i["label"]),
                        ],
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        enableFeedback: true,
                        splashBorderRadius: BorderRadius.circular(10),
                        onTap: (value) {
                          if (_homeController.initialIndex.value == value) {
                            _homeController.tabCtrList[value]().animateToTop();
                          }
                          _homeController.initialIndex.value = value;
                        },
                      ),
                    ),
                  ),
                ]
              ],
              Expanded(
                child: TabBarView(
                  controller: _homeController.tabController,
                  children: _homeController.tabsPageList,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}

class CustomAppBar extends StatelessWidget {
  final double height;
  final Stream<bool>? stream;
  final HomeController? ctr;
  final Function? callback;

  const CustomAppBar({
    super.key,
    this.height = kToolbarHeight,
    this.callback,
    this.ctr,
    this.stream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      initialData: true,
      builder: (context, AsyncSnapshot snapshot) {
        final RxBool isUserLoggedIn = ctr!.userLogin;
        final double top = Get.mediaQuery.padding.top;

        return AnimatedOpacity(
          opacity: snapshot.data ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: AnimatedContainer(
            curve: Curves.easeInOutCubicEmphasized,
            duration: const Duration(milliseconds: 500),
            height: snapshot.data ? top + 52 : top,
            padding: EdgeInsets.fromLTRB(14, top + 6, 14, 0),
            child: UserInfoWidget(
              top: top,
              ctr: ctr,
              userLogin: isUserLoggedIn,
              userFace: ctr?.userFace.value,
              callback: () => callback!(),
            ),
          ),
        );
      },
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    super.key,
    required this.top,
    required this.userLogin,
    required this.userFace,
    required this.callback,
    required this.ctr,
  });

  final double top;
  final RxBool userLogin;
  final String? userFace;
  final VoidCallback? callback;
  final HomeController? ctr;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SearchBar(ctr: ctr),
        if (userLogin.value) ...[
          const SizedBox(width: 4),
          ClipRect(
            child: IconButton(
              onPressed: () => Get.toNamed('/whisper'),
              icon: const Icon(Icons.notifications_none),
            ),
          )
        ],
        const SizedBox(width: 8),
        Obx(() => userLogin.value
            ? Stack(
                children: [
                  NetworkImgLayer(
                    type: 'avatar',
                    width: 34,
                    height: 34,
                    src: userFace,
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => callback?.call(),
                        splashColor: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : DefaultUser(
                callback: () => callback!(),
              )),
      ],
    );
  }
}

class CustomTabs extends StatefulWidget {
  const CustomTabs({super.key});

  @override
  State<CustomTabs> createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs> {
  final HomeController _homeController = Get.find();

  void onTap(int index) {
    feedback();
    if (_homeController.initialIndex.value == index) {
      _homeController.tabCtrList[index]().animateToTop();
    }
    _homeController.initialIndex.value = index;
    _homeController.tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(top: 4),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        itemCount: _homeController.tabs.length,
        itemBuilder: (context, index) {
          String label = _homeController.tabs[index]['label'];
          return Obx(
            () => CustomChip(
              onTap: () => onTap(index),
              label: label,
              selected: index == _homeController.initialIndex.value,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10);
        },
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.onTap,
    required this.label,
    required this.selected,
  });

  final Function onTap;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color secondaryContainer = colorScheme.secondaryContainer;
    final TextStyle chipTextStyle = selected
        ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
        : const TextStyle(fontSize: 13);
    const VisualDensity visualDensity =
        VisualDensity(horizontal: -4.0, vertical: -2.0);

    return InputChip(
      side: BorderSide(
        color: selected
            ? colorScheme.onSecondaryContainer.withOpacity(0.2)
            : Colors.transparent,
      ),
      color: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) => secondaryContainer.withAlpha(200)),
      padding: const EdgeInsets.fromLTRB(7, 1, 7, 1),
      selected: selected,
      selectedColor: secondaryContainer,
      backgroundColor: secondaryContainer,
      label: Text(label, style: chipTextStyle),
      visualDensity: visualDensity,
      showCheckmark: false,
      onPressed: () => onTap(),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.ctr,
  });

  final HomeController? ctr;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        width: 250,
        height: 44,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Material(
          color: colorScheme.onSecondaryContainer.withOpacity(0.05),
          child: InkWell(
            splashColor: colorScheme.primaryContainer.withOpacity(0.3),
            child: Row(
              children: [
                const SizedBox(width: 14),
                Icon(
                  Icons.search_outlined,
                  color: colorScheme.onSecondaryContainer,
                ),
                const SizedBox(width: 10),
                Obx(
                  () => Expanded(
                    child: Text(
                      ctr!.defaultSearch.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: colorScheme.outline),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultUser extends StatelessWidget {
  const DefaultUser({super.key, this.callback});

  final Function? callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      width: 38,
      child: IconButton(
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              return Theme.of(context).colorScheme.onInverseSurface;
            },
          ),
        ),
        onPressed: () => callback?.call(),
        icon: Icon(
          Icons.person_rounded,
          size: 22,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
