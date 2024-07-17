import 'dart:developer';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordDataSource {
  final Dio dio = Dio();

  Future<void> resetPassword({
    required String oldPassWord,
    required String newPassWord,
    required String confirmPassWord,
  }) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString('TOKEN');

      await http.post(Uri.parse(mainApi + '/profile'), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        "Accept-Language": langCode == '' ? "en" : langCode
      }, body: {
        "old_password": oldPassWord,
        "password": newPassWord,
        "password_confirmation": confirmPassWord
      });
    } catch (e) {
      log("Error : ====> $e");
      throw "Oops $e";
    }
  }
}
