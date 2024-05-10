import 'package:get_storage/get_storage.dart';
import 'package:v2ex/models/tabs.dart';
import 'package:v2ex/utils/string.dart';

enum StoreKeys {
  token,
  userInfo,
  loginStatus,
  once,
  replyContent,
  replyItem,
  statusBarHeight,
  themeType,
  signStatus,
  nodes,
  linkOpenInApp,
  expendAppBar,
  noticeOn,
  autoSign,
  eightQuery,
  globalFs,
  htmlFs,
  replyFs,
  tabs,
  autoUpdate,
  highlightOp,
  tempFs,
  sideslip,
  dragOffset,
  displayModeType
}

class GStorage {
  static final GStorage _storage = GStorage._internal();
  final GetStorage _box = GetStorage();

  GStorage._internal();

  factory GStorage() => _storage;

  setToken(String token) => _box.write(StoreKeys.token.toString(), token);

  String getToken() => _box.read<String>(StoreKeys.token.toString())!;

  double getDragOffset() =>
      _box.read<double>(StoreKeys.dragOffset.toString()) ?? 0.0;

  bool getLoginStatus() =>
      _box.read<bool>(StoreKeys.loginStatus.toString()) ?? false;

  Map getUserInfo() => _box.read<Map>(StoreKeys.userInfo.toString()) ?? {};

  List<TabModel> getTabs() {
    List tabs = _box.read<List>(StoreKeys.tabs.toString()) ?? Strings.tabs;
    List<TabModel> list = [];
    for (var i in tabs) {
      list.add(i is TabModel ? i : TabModel.fromJson(i));
    }
    return list;
  }
}
