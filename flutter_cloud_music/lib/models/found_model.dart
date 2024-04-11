import 'package:flutter_cloud_music/models/creative_model.dart';
import 'package:flutter_cloud_music/models/ui_element_model.dart';

class FoundData {
  String? cursor;
  List<Blocks> blocks;
  PageConfig pageConfig;

  FoundData(
    this.cursor,
    this.blocks,
    this.pageConfig,
  );

  factory FoundData.fromJson(Map<String, dynamic> json) => FoundData(
        json["cursor"],
        json["blocks"].map<Blocks>((e) => Blocks.fromJson(e)).toList(),
        PageConfig.fromJson(json["pageConfig"]),
      );
}

class Blocks {
  String blockCode;
  String showType;
  dynamic extInfo;
  UiElementModel? uiElement;
  List<CreativeModel>? creatives;
  bool canClose;

  Blocks(
    this.blockCode,
    this.showType,
    this.extInfo,
    this.uiElement,
    this.creatives,
    this.canClose,
  );

  factory Blocks.fromJson(Map<String, dynamic> json) => Blocks(
        json["blockCode"],
        json["showType"],
        json["extInfo"],
        json["uiElement"] == null
            ? null
            : UiElementModel.fromJson(json["uiElement"]),
        (json["creatives"] as List<dynamic>?)
            ?.map<CreativeModel>((e) => CreativeModel.fromJson(e))
            .toList(),
        json["canClose"],
      );
}

class PageConfig {
  String? refreshToast;
  String? nodataToast;
  int refreshInterval;

  PageConfig(
    this.refreshToast,
    this.nodataToast,
    this.refreshInterval,
  );

  factory PageConfig.fromJson(Map<String, dynamic> json) => PageConfig(
        json["refreshToast"],
        json["nodataToast"],
        json["refreshInterval"],
      );
}
