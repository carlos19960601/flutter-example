import 'dart:developer';
import 'dart:io';

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

  setCookie() async {
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
    // dio.interceptors.add(
    //   LogInterceptor(
    //     request: false,
    //     requestHeader: false,
    //     responseHeader: false,
    //     responseBody: false,
    //   ),
    // );
  }

  get(url, {data, cacheOptions, options, cancelToken, extra}) async {
    Response response;
    Options options = Options();
    ResponseType resType = ResponseType.json;

    if (extra != null) {
      resType = extra["resType"] ?? ResponseType.json;
      if (extra["ua"] != null) {
        options.headers = {"user-agent": headerUa(type: extra["ua"])};
      }
    }

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

  /*
   * post请求
   */
  post(url, {data, queryParameters, options, cancelToken, extra}) async {
    // print('post-data: $data');
    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      // print('post success: ${response.data}');
      return response;
    } on DioException catch (e) {
      print('post error: $e');
      return Future.error(await ApiInterceptor.dioError(e));
    }
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        // print("$count $total");
      });
      print('downloadFile success: ${response.data}');

      return response.data;
    } on DioException catch (e) {
      print('downloadFile error: $e');
      return Future.error(ApiInterceptor.dioError(e));
    }
  }

  // 从cookie中获取 csrf token
  static Future<String> getCsrf() async {
    var cookies = await cookieManager.cookieJar
        .loadForRequest(Uri.parse(HttpString.baseApiUrl));
    String token = '';
    if (cookies.where((e) => e.name == 'bili_jct').isNotEmpty) {
      token = cookies.firstWhere((e) => e.name == 'bili_jct').value;
    }
    return token;
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  String headerUa({type = "mob"}) {
    String headerUa = "";
    if (type == "mob") {
      if (Platform.isIOS) {
        headerUa =
            'Mozilla/5.0 (iPhone; CPU iPhone OS 14_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1 Mobile/15E148 Safari/604.1';
      } else {
        headerUa =
            'Mozilla/5.0 (Linux; Android 10; SM-G975F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.101 Mobile Safari/537.36';
      }
    } else {
      headerUa =
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2 Safari/605.1.15';
    }
    return headerUa;
  }
}
