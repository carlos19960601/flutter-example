import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v2ex/utils/proxy.dart';

Color getBackgroud(BuildContext context, tag) {
  List case1 = ['secondBody', 'homePage', 'adaptMain'];
  List case2 = ['searchBar', 'listItem'];

  bool isiPadHorizontal = Breakpoints.large.isActive(context);
  if (isiPadHorizontal) {
    if (case1.contains(tag)) {
      return Theme.of(context).colorScheme.onInverseSurface;
    } else if (case1.contains(tag)) {
      return Theme.of(context).colorScheme.background;
    } else {
      return Theme.of(context).colorScheme.onInverseSurface;
    }
  } else {
    if (case1.contains(tag)) {
      return Theme.of(context).colorScheme.background;
    } else if (case2.contains(tag)) {
      return Theme.of(context).colorScheme.onInverseSurface;
    } else {
      return Theme.of(context).colorScheme.onInverseSurface;
    }
  }
}

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    CustomProxy().init();

    try {
      await GetStorage.init();
    } catch (err) {
      print('GetStorage err: ${err.toString()}');
    }
  }
}
