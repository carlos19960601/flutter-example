import 'package:pilipala/http/api.dart';
import 'package:pilipala/http/init.dart';
import 'package:pilipala/models/user/info.dart';

class UserHttp {
  static Future<dynamic> userInfo() async {
    var res = await Request().get(Api.userInfo);

    if (res.data["code"] == 0) {
      UserInfoData data = UserInfoData.fromJson(res.data["data"]);
      return {"status": true, "data": data};
    } else {
      return {"status": false, "msg": res.data["message"]};
    }
  }
}
