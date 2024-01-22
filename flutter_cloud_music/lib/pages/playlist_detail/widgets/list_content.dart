import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/controller.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widgets/song_cell.dart';

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
              delegate: SliverChildBuilderDelegate((context, index) {
                if (songs!.length > index) {
                  return NumSongCell(
                    song: songs!.elementAt(index),
                    index: index,
                  );
                } else {
                  return Container();
                }
              }),
            );
    }
  }

  Widget _buildAddSong() {
    return SliverToBoxAdapter(
      child: Container(),
    );
  }
}
