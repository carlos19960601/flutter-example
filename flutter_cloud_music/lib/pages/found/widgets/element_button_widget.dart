import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/constants.dart';
import 'package:flutter_cloud_music/common/functions.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/models/ui_element_model.dart';
import 'package:get/get.dart';

Widget elementButtonWidget(ElementButton? elementButton,
    {ParamVoidCallback? onPressed}) {
  if (elementButton == null) return const SizedBox.shrink();

  return MaterialButton(
    onPressed: () {
      if (onPressed == null) {
      } else {
        onPressed.call();
      }
    },
    height: 24,
    minWidth: 40,
    elevation: 0,
    focusElevation: 0,
    highlightElevation: 0,
    color: Colors.transparent,
    padding: const EdgeInsets.all(0),
    highlightColor: Get.theme.hintColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: Get.theme.hintColor,
      ),
    ),
    child: Row(
      children: [
        const SizedBox(
          width: 12,
        ),
        Text(
          elementButton.text.toString(),
          style: TextStyle(fontSize: 12, color: Get.theme.iconTheme.color),
        ),
        if (elementButton.actionType == APP_ROUTER_TAG)
          Image.asset(
            ImageUtils.getImagePath("icon_more"),
            width: 10,
            height: 10,
            color: Get.theme.iconTheme.color,
          ),
        const SizedBox(
          width: 10,
        ),
      ],
    ),
  );
}
