import 'dart:developer';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:pilipala/http/constants.dart';
import 'package:pilipala/http/interceptor.dart';
import 'package:pilipala/utils/utils.dart';

class Request {
  // 私有的命名函数，声明后，用户无法通过Singleton()创建一个新的对象
  static final Request _instance = Request._internal();
  static late CookieManager cookieManager;
  static late final Dio dio;
  factory Request() => _instance;

  static setCookie() async {
    var cookiePath = await Utils.getCookiePath();
    var cookieJar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage(cookiePath),
    );
    cookieManager = CookieManager(cookieJar);
    dio.interceptors.add(cookieManager);
    var cookie = await cookieManager.cookieJar
        .loadForRequest(Uri.parse(HttpString.tUrl));

    if (cookie.isEmpty) {
      log("cookie is empty");
    }
  }

  Request._internal() {
    BaseOptions options = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: HttpString.baseApiUrl,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: const Duration(milliseconds: 12000),
      persistentConnection: true,
    );

    dio = Dio(options);

    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(LogInterceptor(
      request: false,
      requestHeader: false,
      responseHeader: false,
    ));
  }

  get(url, {data, cacheOptions, options, cancelToken, extra}) async {
    Response response;
    Options options;
    ResponseType resType = ResponseType.json;

    if (cacheOptions != null) {
      options = cacheOptions;
    } else {
      options = Options();
      options.responseType = resType;
    }

    try {
      response = await dio.get(
        url,
        queryParameters: data,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      print("get error: $e");
      return Future.error(await ApiInterceptor.dioError(e));
    }
  }
}
