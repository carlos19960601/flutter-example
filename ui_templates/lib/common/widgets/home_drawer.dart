import 'package:flutter/material.dart';
import 'package:ui_templates/common/app_theme.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    super.key,
    this.screenIndex,
    this.callBackIndex,
  });

  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;

  @override
  void initState() {
    super.initState();
    setDrawerListArray();
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Home',
        icon: const Icon(Icons.home),
      ),
      DrawerList(
        index: DrawerIndex.Help,
        labelName: 'Help',
        isAssetsImage: true,
        imageName: 'assets/images/supportIcon.png',
      ),
      DrawerList(
        index: DrawerIndex.FeedBack,
        labelName: 'FeedBack',
        icon: const Icon(Icons.help),
      ),
      DrawerList(
        index: DrawerIndex.Invite,
        labelName: 'Invite Friend',
        icon: const Icon(Icons.group),
      ),
      DrawerList(
        index: DrawerIndex.Share,
        labelName: 'Rate the app',
        icon: const Icon(Icons.share),
      ),
      DrawerList(
        index: DrawerIndex.About,
        labelName: 'About Us',
        icon: const Icon(Icons.info),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: AppTheme.grey.withOpacity(0.6),
                            offset: const Offset(2.0, 4.0),
                            blurRadius: 8),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(60.0)),
                      child: Image.asset('assets/images/userImage.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      'Chris Hemsworth',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isLightMode ? AppTheme.grey : AppTheme.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList?.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList![index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Column(
            children: [
              ListTile(
                title: const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: const Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () {},
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 6.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                      color: widget.screenIndex == listData.index
                          ? Colors.blue
                          : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? Colors.blue
                                  : AppTheme.nearlyBlack),
                        )
                      : Icon(listData.icon?.icon,
                          color: widget.screenIndex == listData.index
                              ? Colors.blue
                              : AppTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? Colors.black
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75 - 64,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(28),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(28),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
}

enum DrawerIndex {
  HOME,
  FeedBack,
  Help,
  Share,
  About,
  Invite,
  Testing,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
