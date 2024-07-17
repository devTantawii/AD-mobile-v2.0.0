import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:abudiyab/modules/home/payment/data/models/coupon_model.dart';
import 'package:dio/dio.dart';

class CouponRemoteDatasource {
  final Dio _dio;

  CouponRemoteDatasource(this._dio);

  Future<CouponModel> checkCoupon(
      {required String token,
      required String orderID,
      required String code}) async {
    try {
      final Response response = await _dio.post(
        couponPath,
        options: Options(responseType: ResponseType.plain, headers: {
          "Accept": "application/json",
          "content-type" : "application/json",
          "Authorization": "Bearer $token",
        }),
        data: {
          "order_id": orderID,
          "coupon": code,
        },
      );
      return couponModelFromJson(response.data);
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
