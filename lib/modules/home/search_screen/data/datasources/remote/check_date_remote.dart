import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:dio/dio.dart';

class DateCheckerRemote {
  final Dio _dio = Dio();

  Future<String> validate({
    String? languageCode,
    required String receivingId,
    required String deliveryId,
    required String receivingDate,
    required String deliveryDate,
  }) async {
    try {
      final Response response = await _dio.post(dateCheckPoint,
          options: Options(headers: {
            "Accept": "application/json",
            "Accept-Language": langCode == '' ? "en" : langCode
            // 'x-accept-language': languageCode ?? "en",
          }),
          data: {
            'receiving_branche': receivingId,
            'receiving_date': receivingDate,
            'delivery_branche': deliveryId,
            "delivery_date": deliveryDate,
          });
      return response.data['msg'].toString();
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
