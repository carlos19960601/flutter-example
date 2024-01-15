import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/models/creative_model.dart';
import 'package:flutter_cloud_music/models/ui_element_model.dart';

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
    return const Placeholder();
  }
}
