import 'package:flutter_cloud_music/models/ui_element_model.dart';
import 'package:flutter_cloud_music/models/user_info_model.dart';

class CreativeModel {
  String? creativeType;
  String? action;
  List<Resources>? resources;
  UiElementModel? uiElement;
  dynamic creativeExtInfoVO;
  String? algReason;

  CreativeModel(
    this.creativeType,
    this.action,
    this.uiElement,
    this.creativeExtInfoVO,
    this.resources,
    this.algReason,
  );

  factory CreativeModel.fromJson(Map<String, dynamic> json) => CreativeModel(
        json["creativeType"],
        json["action"],
        json["uiElement"] == null
            ? null
            : UiElementModel.fromJson(json["uiElement"]),
        json["creativeExtInfoVO"],
        (json["resources"] as List<dynamic>?)
            ?.map((e) => Resources.fromJson(e))
            .toList(),
        json["algReason"] as String?,
      );
}

class Resources {
  UiElementModel uiElement;
  String? resourceType;
  String? resourceId;
  dynamic resourceExtInfo;
  String? action;
  String? actionType;
  bool valid;

  Resources(
    this.uiElement,
    this.resourceType,
    this.resourceId,
    this.resourceExtInfo,
    this.action,
    this.actionType,
    this.valid,
  );

  factory Resources.fromJson(Map<String, dynamic> json) => Resources(
        UiElementModel.fromJson(json['uiElement']),
        json['resourceType'] as String?,
        json['resourceId'] as String?,
        json['resourceExtInfo'],
        json['action'] as String?,
        json['actionType'] as String?,
        json['valid'] as bool,
      );
}

class ResourceExtInfoModel {
  int playCount;
  bool highQuality;
  List<UserInfo>? users;
  int? specialCover;
  int? specialType;

  ResourceExtInfoModel(
    this.playCount,
    this.highQuality,
    this.users,
    this.specialCover,
    this.specialType,
  );
}
