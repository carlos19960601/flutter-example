import 'package:blackhole/http/api.dart';
import 'package:blackhole/http/saavn.dart';
import 'package:blackhole/models/saavn_home_data.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt bottomTabIndex = 0.obs;

  Rx<SaavnHomeData> saavnHomeData = SaavnHomeData().obs;

  Future quertSaavnHomeData() async {
    ApiResponse<SaavnHomeData> result = await SaavnHttp.getHomePageData();

    if (result.status) {
      saavnHomeData.value = result.data!;
    }

    return result;
  }
}
