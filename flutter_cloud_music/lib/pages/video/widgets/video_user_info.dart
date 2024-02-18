import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/ext/ext.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/widgets/user_avatar.dart';
import 'package:flutter_cloud_music/models/mv_detail_model.dart';
import 'package:flutter_cloud_music/models/video_detail_model.dart';
import 'package:flutter_cloud_music/pages/video/controller/video_list_controller.dart';
import 'package:get/get.dart';

class VideoUserInfoWidget extends StatefulWidget {
  const VideoUserInfoWidget({super.key, required this.controller});

  final VPVideoController controller;

  @override
  State<VideoUserInfoWidget> createState() => _VideoUserInfoWidgetState();
}

class _VideoUserInfoWidgetState extends State<VideoUserInfoWidget> {
  late bool isMv;
  MvDetailModel? _mvDetailModel;
  VideoDetailModel? _videoDetailModel;
  String title = '';
  String? des;
  bool hasMoreDes = false;
  bool showMoreDes = false;

  @override
  void initState() {
    super.initState();
    isMv = widget.controller.videoModel.id.isMv();
    _initData(widget.controller.info.value);
  }

  void _initData(dynamic info) {
    if (info is MvDetailModel) {
      _mvDetailModel = info;
      title = info.name + info.briefDesc;
      des = info.desc;
    } else if (info is VideoDetailModel) {
      _videoDetailModel = info;
      title = info.title;
      des = info.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 80),
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMv)
            _buildListUser(_mvDetailModel?.artists)
          else
            _buildSingleUser(_videoDetailModel?.creator),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              constraints: BoxConstraints(
                maxHeight: Get.mediaQuery.size.height * 2 / 3,
              ),
              child: SingleChildScrollView(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: showMoreDes ? title + ('\n$des') : title,
                        style: const TextStyle(
                            color: AppColors.color217, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSingleUser(VideoCreator? user) {
    return Row(
      children: [
        UserAvatar(
          avatar: user?.avatarUrl ?? '',
          size: 35,
          identityIconUrl: user?.avatarDetail?.identityIconUrl,
          holderAsset: ImageUtils.getImagePath('img_singer_pl', format: 'jpg'),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          user?.nickname ?? '...',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildListAvatar(List<String?> list) {
    return const SizedBox(
      height: 35,
    );
  }

  Widget _buildListUser(List<MvArtists>? artists) {
    if (artists == null || artists.length == 1) {
      return _buildSingleUser(artists?.first.toVideoCreator());
    } else {
      //多个歌手
      return RichText(
          maxLines: 1,
          text: TextSpan(children: [
            TextSpan(
              text: artists.map((e) => e.name).join('/'),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ]));
    }
  }
}
