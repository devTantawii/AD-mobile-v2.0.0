import 'dart:developer';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:dio/dio.dart';

class CancelBookingDataSources {
  final Dio dio;

  final SharedPreferencesHelper sharedPreferencesHelper;

  CancelBookingDataSources(this.dio, this.sharedPreferencesHelper);

  Future<Response> cancelBooking({required int orderId}) async {
    final token = await sharedPreferencesHelper.getToken();
    try {
      final Response response = await dio.put(cancelOrder,
          options: Options(responseType: ResponseType.plain, headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "Accept-Language": langCode == '' ? "en" : langCode,
          }),
          data: {
            "order_id": orderId,
          });
      log(response.toString());
      return response;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }
  Future<Response> deleteBooking({required int orderId}) async {
    final token = await sharedPreferencesHelper.getToken();
    try {
      final Response response = await dio.post(deleteOrder,
          options: Options(responseType: ResponseType.plain, headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "Accept-Language": langCode == '' ? "en" : langCode,
          }),
          data: {
            "order_id": orderId,
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
