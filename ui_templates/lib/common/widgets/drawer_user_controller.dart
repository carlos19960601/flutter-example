import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ui_templates/common/app_theme.dart';
import 'package:ui_templates/common/widgets/home_drawer.dart';

class DrawerUserController extends StatefulWidget {
  const DrawerUserController({
    super.key,
    this.drawerWidth = 250,
    this.onDrawerCall,
    this.screenIndex,
  });
  final double drawerWidth;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? onDrawerCall;

  @override
  State<DrawerUserController> createState() => _DrawerUserControllerState();
}

class _DrawerUserControllerState extends State<DrawerUserController> {
  ScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    scrollController =
        ScrollController(initialScrollOffset: widget.drawerWidth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + widget.drawerWidth,
          child: Row(
            children: [
              SizedBox(
                width: widget.drawerWidth,
                height: MediaQuery.of(context).size.height,
                child: HomeDrawer(
                    screenIndex: widget.screenIndex ?? DrawerIndex.HOME,
                    callBackIndex: (DrawerIndex indexType) {
                      onDrawerClick();
                      try {
                        widget.onDrawerCall!(indexType);
                      } catch (e) {
                        // todo
                      }
                    }),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppTheme.grey.withOpacity(0.6),
                        blurRadius: 24,
                      ),
                    ],
                  ),
                  child: const Stack(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onDrawerClick() {
    if (scrollController!.offset != 0.0) {
      scrollController?.animateTo(0.0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);
    } else {
      scrollController?.animateTo(widget.drawerWidth,
          duration: const Duration(microseconds: 400),
          curve: Curves.fastOutSlowIn);
    }
  }
}
