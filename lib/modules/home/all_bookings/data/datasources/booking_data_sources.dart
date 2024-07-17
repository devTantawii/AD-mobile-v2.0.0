import 'dart:convert';
import 'dart:developer';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:abudiyab/modules/home/all_bookings/data/model/booking_model.dart';
import 'package:abudiyab/modules/home/all_bookings/data/model/check_order_step_model.dart';
import 'package:dio/dio.dart';

class BookingDataSources {
  SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper();
  Future<Booking> getAllBooking({required String status}) async {
    final token = await sharedPreferencesHelper.getToken();
    try {
      final Dio dio = Dio();
      var uri = Uri.parse(getOrders);
      final Response response = await dio.post(
        data:  {
          'status': status,
        },
        uri.toString(),
        options: Options(
          responseType: ResponseType.plain,
            headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "Accept-Language": langCode == '' ? "en" : langCode,
        },),
      );
      final dataOrders = json.decode(response.data);
      final Booking booking = Booking.fromMap(dataOrders);
      return booking;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }

}