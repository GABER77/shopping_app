import 'package:dio/dio.dart';

import 'interceptor.dart';

class DioHelper{
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type' : 'application/json',
        }
      ),
    );

    dio?.interceptors.add(AppInterceptor());
  }

  static Future<Response?> getData({
    required String url,
    required Map<String, dynamic> query,
    String lang = 'en',
    String? authorization,
  }) async {
    dio?.options.headers = {
      'lang' : lang,
      'token' : authorization,
    };
    return await dio?.get(
      url,
      queryParameters: query
    );
  }

  static Future<Response?> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? authorization,

}) async{
    dio?.options.headers = {
      'lang' : lang,
      'token' : authorization,
    };
    return dio?.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

}