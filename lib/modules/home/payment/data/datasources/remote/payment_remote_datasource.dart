import 'dart:convert';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:abudiyab/modules/home/additions/data/models/payment_step_model.dart';
import 'package:abudiyab/modules/home/payment/data/models/credit_card_model.dart';
import 'package:dio/dio.dart';

class PaymentRemoteDatasource {
  final Dio _dio = Dio();

  Future<PaymentStepModel> activePaymentStep(
      {required String token, required CreditCardModel? cardModel}) async {
    try {
      final Response response = await _dio.post(
        paymentPath,
        options: Options(responseType: ResponseType.plain, headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: cardModel!.toJson(),
      );
      // if (response.statusCode == 200) {
      //   print('${response.headers} : ${response.statusCode.toString()}'+'afff');
      // }else{
      //   print('${response.data} : ${response.statusCode.toString()}'+'afff');
      // }
      return paymentStepModelFromJson(response.data);
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }

  Future<PaymentStepModel> activeAutomatedPaymentStep(
      {required String token, required CreditCardModel? cardModel}) async {
    try {
      final Response response = await _dio.post(
        paymentAutomationPath,
        options: Options(responseType: ResponseType.plain, headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: cardModel!.toJson()..addAll({"contract_id": cardModel.orderId}),
      );
      return paymentStepModelFromJson(response.data);
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }

  Future<bool> checkOrderStatus({
    required int orderId,
    required String token,
  }) async {
    try {
      final response = await _dio.post(checkOrderPath,
          options: Options(
            responseType: ResponseType.plain,
            headers: {
              'Content-type': 'application/json',
              "Accept": "application/json",
              "Authorization": "Bearer $token"
            },
          ),
          data: {"order_id": orderId});
      final data = json.decode(response.data);
      final status = data["status"];
      return status;
      // return true;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
