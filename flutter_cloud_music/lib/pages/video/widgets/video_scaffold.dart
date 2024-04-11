import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:get/get.dart';

enum VideoPagePosition {
  right,
  middle,
}

class VideoScaffoldController extends ValueNotifier<VideoPagePosition> {
  VideoScaffoldController([VideoPagePosition value = VideoPagePosition.middle])
      : super(value);
}

class VideoScaffold extends StatefulWidget {
  const VideoScaffold({super.key, required this.header, this.page});

  /// 首页的顶部
  final Widget header;
  final Widget? page;

  @override
  State<VideoScaffold> createState() => _VideoScaffoldState();
}

class _VideoScaffoldState extends State<VideoScaffold> {
  double? screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = Get.mediaQuery.size.width;
    return PopScope(
      child: Scaffold(
        body: Stack(
          children: [
            _MiddlePage(
              header: widget.header,
              page: widget.page,
            )
          ],
        ),
      ),
    );
  }
}

class _MiddlePage extends StatelessWidget {
  const _MiddlePage({
    super.key,
    required this.header,
    this.page,
  });

  final Widget? page;
  final Widget header;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.back1,
          child: page,
        ),
        SafeArea(
          child: SizedBox(
            height: 44,
            child: header,
          ),
        ),
      ],
    );
  }
}
