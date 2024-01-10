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
