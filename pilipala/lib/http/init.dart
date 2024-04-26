import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/http/constants.dart';
import 'package:pilipala/http/interceptor.dart';
import 'package:pilipala/utils/storage.dart';
import 'package:pilipala/utils/utils.dart';

class Request {
  // 私有的命名函数，声明后，用户无法通过Singleton()创建一个新的对象
  static final Request _instance = Request._internal();
  static late CookieManager cookieManager;
  static late final Dio dio;
  factory Request() => _instance;
  Box setting = GStorage.setting;
  static Box localCache = GStorage.localCache;
  late bool enableSystemProxy;
  late String systemProxyHost;
  late String systemProxyPort;

  static setCookie() async {
    var cookiePath = await Utils.getCookiePath();
    var cookieJar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage(cookiePath),
    );
    cookieManager = CookieManager(cookieJar);
    dio.interceptors.add(cookieManager);
    // todo check 登录逻辑
    final List<Cookie> cookie = await cookieManager.cookieJar
        .loadForRequest(Uri.parse(HttpString.baseUrl));

    final String cookieString = cookie
        .map((Cookie cookie) => '${cookie.name}=${cookie.value}')
        .join("; ");

    dio.options.headers["cookie"] = cookieString;
  }

  Request._internal() {
    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: HttpString.apiBaseUrl,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: const Duration(milliseconds: 12000),
      //响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: const Duration(milliseconds: 12000),
      //Http请求头.
      headers: {},
    );

    dio = Dio(options);

    enableSystemProxy = setting.get(SettingBoxKey.enableSystemProxy,
        defaultValue: false) as bool;
    systemProxyHost =
        localCache.get(LocalCacheKey.systemProxyHost, defaultValue: "");
    systemProxyPort =
        localCache.get(LocalCacheKey.systemProxyPort, defaultValue: "");

    // 设置代理
    if (enableSystemProxy) {
      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final HttpClient client = HttpClient();
          client.findProxy = (Uri uri) {
            return "PROXY $systemProxyHost:$systemProxyPort";
          };
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;

          return client;
        },
      );
    }

    dio.interceptors.add(ApiInterceptor());

    dio.interceptors.add(
      LogInterceptor(
        request: false,
        requestHeader: false,
        responseHeader: false,
      ),
    );

    dio.options.validateStatus = (int? status) {
      return status! >= 200 && status < 300 ||
          HttpString.validateStatusCodes.contains(status);
    };
  }

  get(url, {data, options, cancelToken, extra}) async {
    Response response;
    Options options = Options();
    ResponseType resType = ResponseType.json;

    if (extra != null) {
      resType = extra["resType"] ?? ResponseType.json;
      if (extra["ua"] != null) {
        options.headers = {"user-agent": headerUa(type: extra["ua"])};
      }
    }

    options.responseType = resType;

    try {
      response = await dio.get(
        url,
        queryParameters: data,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      Response errResponse = Response(
        data: {"message": await ApiInterceptor.dioError(e)},
        statusCode: 200,
        requestOptions: RequestOptions(),
      );

      return errResponse;
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
      Response errResponse = Response(
        data: {
          'message': await ApiInterceptor.dioError(e)
        }, // 将自定义 Map 数据赋值给 Response 的 data 属性
        statusCode: 200,
        requestOptions: RequestOptions(),
      );
      return errResponse;
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
        .loadForRequest(Uri.parse(HttpString.apiBaseUrl));
    String token = '';
    if (cookies.where((e) => e.name == 'bili_jct').isNotEmpty) {
      token = cookies.firstWhere((e) => e.name == 'bili_jct').value;
    }
    return token;
  }

  String headerUa({type = 'mob'}) {
    String headerUa = '';
    if (type == 'mob') {
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
