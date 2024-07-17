import 'dart:convert';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/constants/preferences_constants.dart';
import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:dio/dio.dart';

class ResetRemotDataSources {
  final Dio dio = Dio();
  Future<Response> resetOldCustomer(
      {required String? email,
      required String? password,
      required String? confPass,
      required String token}) async {
    try {
      final Response response = await dio.post(enterEmailAndPassOldCustomer,
          options: Options(
            responseType: ResponseType.plain,
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
              "Accept-Language": langCode == "" ? "en" : langCode
            },
          ),
          data: {
            "email": email,
            "password": password,
            "password_confirmation": confPass,
            "token": token,
          });
      var data = json.decode(response.data);
      SharedPreferencesHelper sharedPreferences = SharedPreferencesHelper();
      sharedPreferences.set(PreferencesConstants.token, data['token']);

      return response;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
