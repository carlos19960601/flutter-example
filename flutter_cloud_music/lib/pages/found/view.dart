import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/models/banner_model.dart';
import 'package:flutter_cloud_music/models/found_model.dart';
import 'package:flutter_cloud_music/pages/found/controller.dart';
import 'package:flutter_cloud_music/pages/found/widgets/found_appbar.dart';
import 'package:flutter_cloud_music/pages/found/widgets/found_banner.dart';
import 'package:flutter_cloud_music/pages/found/widgets/found_header_bg.dart';
import 'package:flutter_cloud_music/pages/found/widgets/found_slied_playlist.dart';
import 'package:get/get.dart';
import 'package:flutter_cloud_music/common/show_types.dart';

class FoundPage extends StatelessWidget {
  FoundPage({super.key});

  final FoundController controller = Get.put(FoundController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: FoundAppbar(),
      body: Stack(
        children: [
          const Positioned(
            top: 0,
            child: FoundHeaderColors(),
          ),
          Positioned.fill(
            top: Get.mediaQuery.padding.top + kToolbarHeight,
            child: _buildListView(context),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    final ScrollController listScroll = ScrollController();
    listScroll.addListener(() {
      controller.isScrolled.value = listScroll.position.pixels >= 15;
    });
    return Obx(
      () => ListView.separated(
        padding: const EdgeInsets.only(bottom: 20),
        controller: listScroll,
        itemBuilder: (BuildContext context, int index) {
          final blocks = controller.foundData.value!.blocks[index];
          final nextType = index + 1 < controller.foundData.value!.blocks.length
              ? controller.foundData.value!.blocks[index + 1].showType
              : null;

          return _buildItem(blocks, index, nextType);
        },
        separatorBuilder: (BuildContext context, int index) {
          final nextType = index + 1 < controller.foundData.value!.blocks.length
              ? controller.foundData.value!.blocks[index + 1].showType
              : null;

          return _buildDivider(
              controller.foundData.value!.blocks[index].showType, nextType);
        },
        itemCount: controller.foundData.value != null
            ? controller.foundData.value!.blocks.length
            : 0,
      ),
    );
  }

  Widget _buildDivider(String type, String? nextType) {
    switch (type) {
      case SHOWTYPE_BANNER:
        return const SizedBox.shrink();
      default:
        return const SizedBox(height: 10);
    }
  }

  Widget _buildItem(Blocks blocks, int index, String? nextType) {
    final itemHeight = controller.itemHeightFromType[blocks.showType] ?? 0;

    switch (blocks.showType) {
      case SHOWTYPE_BANNER:
        return FoundBanner(
          bannerModel: BannerModel.fromJson(blocks.extInfo),
          itemHeight: itemHeight,
        );
      case SHOWTYPE_HOMEPAGE_SLIDE_PLAYLIST:
        return FoundSliedPlaylist(
          uiElementModel: blocks.uiElement!,
          creatives: blocks.creatives!,
          curIndex: index,
          itemHeight: itemHeight,
        );
      default:
        return Container(
          width: Get.width,
          height: 100,
          color: Get.theme.cardColor,
          child: Text('未适配类型: ${blocks.showType}'),
        );
    }
  }
}
