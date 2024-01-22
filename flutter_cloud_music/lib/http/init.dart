import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_cloud_music/http/constants.dart';
import 'package:flutter_cloud_music/http/interceptor.dart';

class Request {
  // 私有的命名函数，声明后，用户无法通过Singleton()创建一个新的对象
  static final Request _instance = Request._internal();
  static late final Dio dio;
  factory Request() => _instance;

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
    dio.interceptors.add(
      LogInterceptor(
        request: false,
        requestHeader: false,
        responseHeader: false,
        responseBody: false,
      ),
    );
  }

  get(url, {data}) async {
    Response response;
    Options options = Options();
    ResponseType resType = ResponseType.json;

    options.responseType = resType;
    try {
      response = await dio.get(
        url,
        queryParameters: data,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      log("get error: $e");
      return Future.error(await ApiInterceptor.dioError(e));
    }
  }

  /*
   * post请求
   */
  Future<Response<dynamic>> post(url, {data, queryParameters}) async {
    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      log('post error: $e');
      return Future.error(await ApiInterceptor.dioError(e));
    }
  }

  /*
   * delete请求
   */
  Future<Response<dynamic>> delete(url, {data, queryParameters}) async {
    Response response;
    try {
      response = await dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      log('post error: $e');
      return Future.error(await ApiInterceptor.dioError(e));
    }
  }
}
