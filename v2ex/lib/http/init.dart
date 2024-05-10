import 'dart:io';

import 'package:dio/dio.dart';
import 'package:v2ex/utils/string.dart';

class Request {
  static final Request _instance = Request._internal();
  static late final Dio dio;
  factory Request() => _instance;

  Request._internal() {
    BaseOptions options = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: Strings.v2exHost,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: const Duration(milliseconds: 12000),
      //响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: const Duration(milliseconds: 12000),
    );

    dio = Dio(options);

    dio.interceptors.add(LogInterceptor(
        request: false, requestHeader: false, responseHeader: false));

    dio.options.validateStatus = (status) {
      return status! >= 200 && status < 300 || status == 304 || status == 302;
    };
  }

  /*
   * get请求
   */
  get(url, {data, cacheOptions, options, cancelToken, extra}) async {
    // extra pc ok , mob error
    Response response;
    Options options;
    String ua = 'mob';
    ResponseType resType = ResponseType.json;
    if (extra != null) {
      ua = extra!['ua'] ?? 'mob';
      resType = extra!['resType'] ?? ResponseType.json;
    }
    // headerUa(pc) ResponseType.json;
    if (cacheOptions != null) {
      cacheOptions.headers = {'user-agent': headerUa(ua)};
      options = cacheOptions;
    } else {
      options = Options();
      options.headers = {'user-agent': headerUa(ua)};
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
      print('get error---------$e');
      return Future.error(ApiInterceptor.dioError(e));
    }
  }

  /*
   * post请求
   */
  post(url, {data, options, cancelToken, extra}) async {
    print('post-data: $data');
    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
      print('post success---------${response.data}');
      return response;
    } on DioException catch (e) {
      print('post error---------$e');
      return Future.error(ApiInterceptor.dioError(e));
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
      print('downloadFile success---------${response.data}');

      return response.data;
    } on DioException catch (e) {
      print('downloadFile error---------$e');
      return Future.error(ApiInterceptor.dioError(e));
    }
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

  String headerUa(ua) {
    String headerUa = '';
    if (ua == 'mob') {
      headerUa = Platform.isIOS
          ? 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1'
          : 'Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.91 Mobile Safari/537.36';
    } else if (ua == 'mobMoto') {
      headerUa =
          "User-Agent: MOT-V9mm/00.62 UP.Browser/6.2.3.4.c.1.123 (GUI) MMP/2.0";
    } else {
      headerUa =
          'Mozilla/5.0 (MaciMozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36';
    }
    return headerUa;
  }
}
