import 'dart:convert';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:dio/dio.dart';

class EditOrderRemoteDatasource {
  final Dio dio;

  final SharedPreferencesHelper sharedPreferencesHelper;

  EditOrderRemoteDatasource(this.dio, this.sharedPreferencesHelper);

  Future<String?>? editBooking({
    required int orderId,
    required String receivingId,
    required String deliveryId,
    required String receivingDate,
    required String deliveryDate,
  }) async {
    final token = await sharedPreferencesHelper.getToken();
    try {
      final Response response = await dio.put(editOrder + orderId.toString(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
            "Accept-Language": langCode == '' ? "en" : langCode,
          }),
          data: {
            'receiving_branch': receivingId,
            'reciving_date': receivingDate,
            'delivery_branch': deliveryId,
            "delivery_date": deliveryDate,
          });
      final  msg =json.decode(response.data) as Map<String,dynamic>;
      return msg['msg'];
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
