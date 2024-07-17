import 'dart:developer';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:dio/dio.dart';

class CancelBookingAutomationDataSources {
  final Dio dio;

  final SharedPreferencesHelper sharedPreferencesHelper;

  CancelBookingAutomationDataSources(this.dio, this.sharedPreferencesHelper);

  Future<Response> cancelBookingAutomation({required int orderId}) async {
    final token = await sharedPreferencesHelper.getToken();
    try {
      final Response response = await dio.post(cancelBookingAutomationPath,
          options: Options(responseType: ResponseType.plain, headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "Accept-Language": langCode == '' ? "en" : langCode,
          }),
          data: {
            "contract_id": orderId,
          });
      log(response.toString());
      return response;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
