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

  String getName() {
    return detailValue?.userDetail?.profile.artistName ??
        detailValue?.userDetail?.profile.nickname ??
        detailValue?.singerDetail?.artist.name ??
        '';
  }
}

class SingerOrUserDetail {
  final bool isSinger;

  final SingerDetailModel? singerDetail;

  final UserDetailModel? userDetail;

  const SingerOrUserDetail(this.isSinger, this.singerDetail, this.userDetail);
}
