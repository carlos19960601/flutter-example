import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
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
