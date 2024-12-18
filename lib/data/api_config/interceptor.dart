import 'dart:developer';
import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST[${options.method}] => PATH: ${options.baseUrl + options.path}');
    log('REQUEST BODY: ${options.data}');
    log('REQUEST HEADERS: ${options.headers}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE STATUS: ${response.statusCode}');
    log('RESPONSE BODY: $response');
    super.onResponse(response, handler);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) {
    log('ERROR[${err.response?.statusCode}] => STATUS MESSAGE: ${err.response?.statusMessage}');
    log('RESPONSE BODY: ${err.response}');
    super.onError(err, handler);
  }
}