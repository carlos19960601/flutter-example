import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/http/dynamics.dart';
import 'package:pilipala/models/common/dynamics_type.dart';
import 'package:pilipala/models/dynamics/result.dart';
import 'package:pilipala/models/dynamics/up.dart';
import 'package:pilipala/utils/feed_back.dart';
import 'package:pilipala/utils/storage.dart';

class DynamicsController extends GetxController {
  int page = 1;
  String? offset = "";
  RxList<DynamicItemModel> dynamicsList = [DynamicItemModel()].obs;
  Rx<DynamicsType> dynamicsType = DynamicsType.values[0].obs;
  RxString dynamicsTypeLable = "全部".obs;
  final ScrollController scrollController = ScrollController();
  Rx<FollowUpModel> upData = FollowUpModel().obs;
  // 默认获取全部动态
  RxInt mid = (-1).obs;
  Rx<UpItem> upInfo = UpItem().obs;
  List filterTypeList = [
    {
      'label': DynamicsType.all.labels,
      'value': DynamicsType.all,
      'enabled': true
    },
    {
      'label': DynamicsType.video.labels,
      'value': DynamicsType.video,
      'enabled': true
    },
    {
      'label': DynamicsType.pgc.labels,
      'value': DynamicsType.pgc,
      'enabled': true
    },
    {
      'label': DynamicsType.article.labels,
      'value': DynamicsType.article,
      'enabled': true
    },
  ];
  RxInt initialValue = 0.obs;
  RxBool userLogin = false.obs;
  Box userInfoCache = GStorage.userInfo;
  var userInfo;
  RxBool isLoadingDynamic = false.obs;

  @override
  void onInit() {
    super.onInit();
    userInfo = userInfoCache.get('userInfoCache');
    userLogin.value = userInfo != null;
    dynamicsType = DynamicsType.values[initialValue.value].obs;
  }

  onSelectType(value) async {
    dynamicsType.value = filterTypeList[value]['value'];
    dynamicsList.value = [DynamicItemModel()];
    page = 1;
    initialValue.value = value;
    await queryFollowDynamic();
    scrollController.jumpTo(0);
  }

  onSelectUp(mid) async {
    dynamicsType.value = DynamicsType.values[0];
    dynamicsList.value = <DynamicItemModel>[];
    page = 1;
    queryFollowDynamic();
  }

  pushDetail(item, floor, {action = "all"}) async {
    feedback();

    if (action == "comment") {
      Get.toNamed('/dynamicDetail',
          arguments: {'item': item, 'floor': floor, 'action': action});
      return false;
    }
  }

  Future queryFollowDynamic({type = "init"}) async {
    if (!userLogin.value) {
      return {'status': false, 'msg': '账号未登录'};
    }
    if (type == 'init') {
      dynamicsList.clear();
    }
    // 下拉刷新数据渲染时会触发onLoad
    if (type == 'onLoad' && page == 1) {
      return;
    }
    isLoadingDynamic.value = true;
    var res = await DynamicsHttp.followDynamic(
      page: type == 'init' ? 1 : page,
      type: dynamicsType.value.values,
      offset: offset,
      mid: mid.value,
    );
    isLoadingDynamic.value = false;
    if (res['status']) {
      if (type == 'onLoad' && res['data'].items.isEmpty) {
        SmartDialog.showToast('没有更多了');
        return;
      }
      if (type == 'init') {
        dynamicsList.value = res['data'].items;
      } else {
        dynamicsList.addAll(res['data'].items);
      }
      offset = res['data'].offset;
      page++;
    }
    return res;
  }

  Future queryFollowUp({type = 'init'}) async {
    if (!userLogin.value) {
      return {'status': false, 'msg': '账号未登录'};
    }

    if (type == 'init') {
      upData.value.upList = <UpItem>[];
      upData.value.liveUsers = LiveUsers();
    }
    var res = await DynamicsHttp.followUp();
    if (res['status']) {
      upData.value = res['data'];
      if (upData.value.upList!.isEmpty) {
        mid.value = -1;
      }
      upData.value.upList!.insertAll(0, [
        UpItem(face: '', uname: '全部动态', mid: -1),
        UpItem(face: userInfo.face, uname: '我', mid: userInfo.mid),
      ]);
    }
    return res;
  }

  onRefresh() async {
    page = 1;
    print('onRefresh');
    await queryFollowUp();
    await queryFollowDynamic();
  }
}
