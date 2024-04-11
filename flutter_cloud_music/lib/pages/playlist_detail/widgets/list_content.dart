import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/controller.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widgets/song_cell.dart';
import 'package:get/get.dart';

class PlayListContent extends StatelessWidget {
  PlayListContent({
    super.key,
    required this.songs,
    required this.controller,
  });

  List<Song>? songs;
  final PlaylistDetailController controller;

  @override
  Widget build(BuildContext context) {
    if (songs == null) {
      return SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.only(top: 95),
        ),
      );
    } else {
      return songs!.isEmpty
          ? _buildAddSong()
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (songs!.length > index) {
                    return NumSongCell(
                      song: songs!.elementAt(index),
                      index: index,
                      clickCallback: () {
                        final clickSong = songs!.elementAt(index);
                        if (clickSong.canPlay()) {
                          PlayerService.to.curPlayId.value = clickSong.id;
                          PlayerService.to.curPlay.value = clickSong;
                        } else {
                          toast('该歌曲暂无法播放');
                        }
                      },
                    );
                  } else {
                    return Container(
                      height: 58,
                      color: Get.theme.cardColor,
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    );
                  }
                },
                childCount: songs!.length,
              ),
            );
    }
  }

  Widget _buildAddSong() {
    return SliverToBoxAdapter(
      child: Container(),
    );
  }
}
