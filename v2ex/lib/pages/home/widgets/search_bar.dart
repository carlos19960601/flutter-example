import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:v2ex/routes/app_routes.dart';
import 'package:v2ex/services/i18n_keyword.dart';
import 'package:v2ex/utils/storage.dart';
import 'package:v2ex/widgets/avatar.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key, this.userInfo});

  final userInfo;

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  bool loginStatus = false;
  Map userInfo = {};
  bool unRead = false;

  @override
  void initState() {
    super.initState();
    if (GStorage().getLoginStatus()) {
      loginStatus = true;
      readUserInfo();
    }
  }

  void readUserInfo() {
    if (GStorage().getUserInfo() != {}) {
      Map userInfoStorage = GStorage().getUserInfo();
      setState(() {
        userInfo = userInfoStorage;
        loginStatus = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.search),
      child: SizedBox(
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.onInverseSurface,
            padding: const EdgeInsets.only(left: 4, right: 8),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      tooltip: I18nKeyword.drawer.tr,
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu),
                    ),
                    Center(
                      child: Text(
                        I18nKeyword.search.tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (userInfo.isNotEmpty) {
                        } else {
                          var res = await Get.toNamed(AppRoutes.login);
                          if (res != null) {
                            if (res["loginStatus"] == "cancel") {
                              SmartDialog.showToast("取消登录");
                            } else {
                              SmartDialog.showToast("登录成功");
                              setState(() {
                                loginStatus = true;
                              });
                              readUserInfo();
                            }
                          }
                        }
                      },
                      child: loginStatus && userInfo.isNotEmpty
                          ? Hero(
                              tag: userInfo["userName"],
                              child: CAvatar(
                                url: userInfo["avatar"],
                                size: 37,
                              ))
                          : Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              clipBehavior: Clip.antiAlias,
                              width: 37,
                              height: 37,
                              child: Center(
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 22,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                    )
                  ],
                ),
                Visibility(
                  visible: loginStatus,
                  child: Positioned(
                    right: 38,
                    top: 0,
                    child: IconButton(
                      tooltip: I18nKeyword.notice.tr,
                      icon: Icon(
                        Icons.notifications_none_rounded,
                        color: unRead
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            unRead = false;
                          },
                        );
                        Get.toNamed(AppRoutes.notifications);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
