import 'package:flutter_cloud_music/models/user_info_model.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';

class MinePlaylist extends Object {
  int trackCount;
  int specialType;
  String name;
  String coverImgUrl;
  int id;
  int privacy;
  UserInfo creator;

  MinePlaylist(
    this.trackCount,
    this.specialType,
    this.name,
    this.coverImgUrl,
    this.id,
    this.privacy,
    this.creator,
  );

  factory MinePlaylist.fromJson(Map<String, dynamic> json) => MinePlaylist(
        json['trackCount'] as int,
        json['specialType'] as int,
        json['name'] as String,
        json['coverImgUrl'] as String,
        json['id'] as int,
        json['privacy'] as int,
        UserInfo.fromJson(json['creator'] as Map<String, dynamic>),
      );

  bool isIntelligent() {
    return specialType == 5;
  }

  bool isMineCreate() {
    return creator.userId == AuthService.to.userId && !isIntelligent();
  }

  bool isMyPl() {
    return AuthService.to.userId == creator.userId;
  }

  String getCountAndBy() {
    if (isMyPl()) {
      return '$trackCount首';
    }
    return '$trackCount首, by ${creator.nickname}';
  }
}
