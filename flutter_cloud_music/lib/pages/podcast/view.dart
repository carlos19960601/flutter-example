import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/pages/singer_list/view.dart';

///<博客>页面没有相关API 用歌手列表代替
class PodcastPage extends StatelessWidget {
  const PodcastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("歌手分类"),
      ),
      body: SingerListPage(),
    );
  }
}
