import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/found/models/shuffle_log_model.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/controller.dart';

class VideoListContent extends StatelessWidget {
  VideoListContent({
    super.key,
    required this.videos,
    required this.controller,
  });

  List<MLogResource>? videos;
  final PlaylistDetailController controller;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
