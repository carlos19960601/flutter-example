import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/models/dynamics/up.dart';
import 'package:pilipala/utils/storage.dart';

class UpPanel extends StatefulWidget {
  final FollowUpModel? upData;
  const UpPanel(this.upData, {super.key});

  @override
  State<StatefulWidget> createState() => _UpPanelState();
}

class _UpPanelState extends State<UpPanel> {
  final ScrollController scrollController = ScrollController();
  Box userInfoCache = GStorage.userInfo;
  var userInfo;
  List<UpItem> upList = [];

  @override
  void initState() {
    super.initState();
    upList = widget.upData!.upList!;
    upList.insert(
      0,
      UpItem(
          face: 'https://files.catbox.moe/8uc48f.png', uname: '全部动态', mid: -1),
    );
    userInfo = userInfoCache.get("userInfoCache");
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      delegate: _SliverHeaderDelegate(
        height: 90,
        child: Container(
          height: 90,
          child: Row(
            children: [
              Expanded(
                  child: ListView(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  for (int i = 0; i < upList.length; i++) ...[
                    upItemBuild(upList[i], i)
                  ]
                ],
              )),
              Material(
                child: InkWell(
                  onTap: () => {Get.to("/follow?mid=${userInfo.mid}")},
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    color: Theme.of(context)
                        .colorScheme
                        .secondaryContainer
                        .withOpacity(0.3),
                    child: Center(
                      child: Text(
                        "全部",
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UpPanelSkeleton extends StatelessWidget {
  const UpPanelSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            children: [
              Container(
                width: 49,
                height: 49,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(24),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 6),
                width: 45,
                height: 12,
                color: Theme.of(context).colorScheme.onInverseSurface,
              )
            ],
          ),
        );
      },
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SliverHeaderDelegate({required this.height, required this.child});

  final double height;
  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
