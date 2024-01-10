import 'package:flutter/material.dart';
import 'package:ui_templates/common/app_theme.dart';
import 'package:ui_templates/common/widgets/drawer_user_controller.dart';
import 'package:ui_templates/common/widgets/home_drawer.dart';
import 'package:ui_templates/pages/feedback/view.dart';
import 'package:ui_templates/pages/help/view.dart';
import 'package:ui_templates/pages/home/view.dart';

class NavigationHomePage extends StatefulWidget {
  const NavigationHomePage({super.key});

  @override
  State<NavigationHomePage> createState() => _NavigationHomePageState();
}

class _NavigationHomePageState extends State<NavigationHomePage> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    super.initState();
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = const MyHomePage();
          });
          break;
        case DrawerIndex.Help:
          setState(() {
            screenView = const HelpPage();
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            screenView = const FeedbackPage();
          });
          break;
        // case DrawerIndex.Invite:
        //   setState(() {
        //     screenView = InviteFriend();
        //   });
        //   break;
        default:
          break;
      }
    }
  }
}
