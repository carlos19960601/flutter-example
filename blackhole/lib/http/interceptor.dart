import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // print("请求之前");
    // 在请求之前添加头部或认证信息
    // options.headers['Authorization'] = 'Bearer token';
    // options.headers['Content-Type'] = 'application/json';
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  static Future dioError(DioException error) async {
    switch (error.type) {
      case DioExceptionType.badCertificate:
        return '证书有误！';
      case DioExceptionType.badResponse:
        return '服务器异常，请稍后重试！';
      case DioExceptionType.cancel:
        return "请求已被取消，请重新请求";
      case DioExceptionType.connectionError:
        return '连接错误，请检查网络设置';
      case DioExceptionType.connectionTimeout:
        return "网络连接超时，请检查网络设置";
      case DioExceptionType.receiveTimeout:
        return "响应超时，请稍后重试！";
      case DioExceptionType.sendTimeout:
        return "发送请求超时，请检查网络设置";
      default:
        return "Dio异常";
    }
  }
}
