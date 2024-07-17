import 'package:abudiyab/core/helpers/interceptors/pretty_dio_logger.dart';
import 'package:dio/dio.dart';

import '../../service_locator.dart';
import 'interceptors/app_interceptor.dart';

/// Handle Http Request
class NetworkHelper {

  static Dio get instanceDio {
    Dio dio = sl();
    dio.interceptors.add(AppInterceptors(sl()));
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    return dio;
  }

  static Future<Response> post(String path, {dynamic data}) async {
    return instanceDio.post(
      path,
      data: data,
    );
  }

  static Future<Response> put(String path, {dynamic data}) async {
    return instanceDio.put(
      path,
      data: data,
    );
  }

  static Future<Response> patch(String path, {dynamic data}) async {
    return instanceDio.patch(
      path,
      data: data,
    );
  }

  static Future<Response> get(String path,
      {dynamic queryParameters, token}) async {
    return instanceDio.get(path, queryParameters: queryParameters);
  }

  static Future<Response> delete(String path, {token}) {
    return instanceDio.delete(path);
  }
}

