import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/utils/route_utils.dart';
import 'package:flutter_cloud_music/common/widgets/custom_tap.dart';
import 'package:flutter_cloud_music/models/creative_model.dart';
import 'package:flutter_cloud_music/models/ui_element_model.dart';
import 'package:flutter_cloud_music/pages/found/widgets/element_title_widget.dart';
import 'package:get/get.dart';

class FoundSliedPlaylist extends StatelessWidget {
  const FoundSliedPlaylist({
    super.key,
    required this.uiElementModel,
    required this.creatives,
    required this.curIndex,
    required this.itemHeight,
  });

  final UiElementModel uiElementModel;
  final List<CreativeModel> creatives;
  final int curIndex;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
      ),
      child: SizedBox(
        height: itemHeight,
        child: Column(
          children: [
            ElementTitleWidget(
              elementModel: uiElementModel,
            ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemBuilder: (context, index) {
                  final model = creatives[index];
                  return Bounce(
                    onPressed: () {
                      RouteUtils.routeFromActionStr(model.action);
                    },
                    child: _buildItem(model),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 9);
                },
                itemCount: creatives.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(CreativeModel model) {
    if (GetUtils.isNullOrBlank(model.resources) == true) {
      return const SizedBox.shrink();
    }

    if (model.creativeType == "scroll_playlist") {
      return const SizedBox.shrink();
    } else {
      final resource = model.resources![0];
      return SizedBox(
        width: 109,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: ImageUtils.getImageUrlFromSize(
                  resource.uiElement.image?.imageUrl,
                  const Size(105, 105),
                ),
                imageBuilder: (context, imageProvider) {
                  return Stack(
                    children: [
                      Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 5),
            Text(
              resource.uiElement.mainTitle?.title ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
    }
  }
}
