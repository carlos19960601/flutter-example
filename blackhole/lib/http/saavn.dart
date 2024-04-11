import 'dart:convert';
import 'dart:developer';

import 'package:blackhole/http/api.dart';
import 'package:blackhole/http/init.dart';
import 'package:blackhole/models/saavn_home_data.dart';
import 'package:dio/dio.dart';

class SaavnHttp {
  static Future<dynamic> getHomePageData() async {
    Response<dynamic> res = await Request().get(
      "/api.php",
      data: {
        "_format": "json",
        "_marker": 0,
        "ctx": "web6dot0",
        "__call": "webapi.getLaunchData",
      },
    );

    log(res.data);

    return ApiResponse(
      status: true,
      data: SaavnHomeData.fromJson(json.decode(res.data)),
    );
  }
}
