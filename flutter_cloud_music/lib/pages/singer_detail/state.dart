import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/models/singer_detail_model.dart';
import 'package:flutter_cloud_music/models/user_detail_model.dart';
import 'package:get/get.dart';

class SingerDetailState {
  //用户ID 如果是入驻歌手 也有用户ID
  final Rxn<String> accountId = Rxn<String>();

  //歌手ID 获取详情如果没有{accountId}就用这个ID
  String? artistId;

  //详情
  final Rxn<SingerOrUserDetail> detail = Rxn<SingerOrUserDetail>();
  SingerOrUserDetail? get detailValue => detail.value;

  //吸顶
  final isPinned = false.obs;

  late ScrollController scrollController;

  List<SingerTabModel>? tabs;
  TabController? tabController;

  SingerDetailState() {
    scrollController = ScrollController();
  }

  String getName() {
    return detailValue?.userDetail?.profile.artistName ??
        detailValue?.userDetail?.profile.nickname ??
        detailValue?.singerDetail?.artist.name ??
        '';
  }

  bool isSinger() {
    return getArtistId() != null;
  }

  int? getArtistId() {
    return detailValue?.userDetail?.profile.artistId ??
        detailValue?.singerDetail?.artist.id;
  }

  int? getAlbumSize() {
    if (detailValue?.singerDetail != null) {
      return detailValue!.singerDetail!.artist.albumSize;
    }
    if (detailValue?.userDetail != null) {
      return detailValue!.userDetail!.singerModel?.artist.albumSize;
    }
    return null;
  }

  int? getMVSize() {
    if (detailValue?.singerDetail != null) {
      return detailValue!.singerDetail!.artist.mvSize;
    }
    if (detailValue?.userDetail != null) {
      return detailValue!.userDetail!.singerModel?.artist.mvSize;
    }
    return null;
  }
}

class SingerOrUserDetail {
  final bool isSinger;

  final SingerDetailModel? singerDetail;

  final UserDetailModel? userDetail;

  const SingerOrUserDetail(this.isSinger, this.singerDetail, this.userDetail);
}

class SingerTabModel {
  final SingerTabType type;

  final String title;

  final int? num;

  const SingerTabModel({required this.type, required this.title, this.num});
}

enum SingerTabType {
  homePage,
  songPage,
  albumPage,
  evenPage,
  mvPage,
}
