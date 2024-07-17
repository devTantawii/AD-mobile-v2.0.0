import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:dio/dio.dart';

class CodeRemotDataSources {
  final Dio dio = Dio();
  Future<Response> enterodeOldCustomer(
      {required String? code, required String token}) async {
    try {
      final Response response = await dio.post(enterCodeOldCustomer,
          options: Options(
            responseType: ResponseType.plain,
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
              "Accept-Language": langCode == "" ? "en" : langCode
            },
          ),
          data: {
            "code": code,
            "token": token,
          });

      return response;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
