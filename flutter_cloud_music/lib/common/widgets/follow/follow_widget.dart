import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/functions.dart';

class FollowWidget extends StatefulWidget {
  const FollowWidget({
    super.key,
    required this.id,
    required this.isFollowed,
    this.isFollowedCallback,
    this.isSolidWidget = false,
    this.isSinger = true,
  });

  final String id; //歌手ID
  final bool isFollowed; //是否已经关注
  final bool isSolidWidget; //是否是实心widget
  final bool isSinger; // 是否是歌手
  final ParamSingleCallback<bool>? isFollowedCallback;

  @override
  State<FollowWidget> createState() => _FollowWidgetState();
}

class _FollowWidgetState extends State<FollowWidget> {
  late bool isFollowed;

  @override
  void initState() {
    super.initState();
    isFollowed = widget.isFollowed;
  }

  @override
  Widget build(BuildContext context) {
    final txtStyle = TextStyle(
      fontSize: 13,
      color: isFollowed
          ? AppColors.textGray
          : widget.isSolidWidget
              ? Colors.white
              : AppColors.appMainLight,
    );

    return Container(
      decoration: const BoxDecoration(),
      child: GestureDetector(
        child: Row(
          children: [
            Text(
              isFollowed ? '已关注' : '关注',
              style: txtStyle.copyWith(fontSize: isFollowed ? 12 : 13),
            )
          ],
        ),
      ),
    );
  }
}
