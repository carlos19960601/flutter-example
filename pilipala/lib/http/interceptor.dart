import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:pilipala/utils/storage.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      if (response.statusCode == 302) {
        List<String> locations = response.headers["location"]!;
        if (locations.isNotEmpty) {
          if (locations.first.startsWith("https://www.mcbbs.net")) {
            final uri = Uri.parse(locations.first);
            final accessKey = uri.queryParameters["access_key"];
            final mid = uri.queryParameters["mid"];
            try {
              Box localCache = GStorage.localCache;
              localCache.put(
                  LocalCacheKey.accessKey, {"mid": mid, "value": accessKey});
            } catch (_) {}
          }
        }
      }
    } catch (err) {
      print("ApiInterceptor: $err");
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }

  static Future dioError(DioException error) async {
    switch (error.type) {
      case DioExceptionType.badCertificate:
        return "证书有误";
      case DioExceptionType.badResponse:
        return '服务器异常，请稍后重试！';
      default:
        return "Dio异常";
    }
  }
}
