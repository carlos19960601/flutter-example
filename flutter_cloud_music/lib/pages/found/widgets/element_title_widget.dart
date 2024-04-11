import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/functions.dart';
import 'package:flutter_cloud_music/common/utils/theme_utils.dart';
import 'package:flutter_cloud_music/models/ui_element_model.dart';
import 'package:flutter_cloud_music/pages/found/widgets/element_button_widget.dart';
import 'package:get/get.dart';

class ElementTitleWidget extends StatelessWidget {
  const ElementTitleWidget({
    super.key,
    required this.elementModel,
    this.onPressed,
  });

  final UiElementModel elementModel;

  final ParamVoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.only(top: 5),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          if (!GetUtils.isNull(elementModel.subTitle))
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 240,
                    child: Text(
                      elementModel.subTitle!.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: headlineStyle(),
                    ),
                  )
                ],
              ),
            ),
          if (!GetUtils.isNull(elementModel.button))
            Expanded(
              flex: 0,
              child: elementButtonWidget(elementModel.button),
            ),
        ],
      ),
    );
  }
}
