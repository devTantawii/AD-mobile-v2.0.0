import 'dart:convert';
import 'dart:developer';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordDataSourse {
  String? token;
  Future<String> forgetPassword({required String phone}) async {
    var responce = await http.post(
      Uri.parse(passwordForget),
      body: {"username": phone},
      headers: {
        "Accept": "application/json",
        "Accept-Language": langCode == '' ? "en" : langCode
      },
    );
    var data = json.decode(responce.body);

    if (responce.statusCode == 200) {
      token = data['token'];
      return data['token'];
    } else {
      return throw Exception(data['errors']['username']);
    }
  }

  Future<String> postCode(String code) async {
    var responce = await http.post(
      Uri.parse(codeForget),
      body: {"token": token, "code": code},
      headers: {
        "Accept": "application/json",
        "Accept-Language": langCode == '' ? "en" : langCode
      },
    );
    log(token.toString());
    var data = json.decode(responce.body);
    log(data['reset_token']);
    if (responce.statusCode == 200) {
      return data['reset_token'];
    } else {
      return throw Exception(data['errors']['code']);
    }
  }

  Future<void> resetPassword(String password, String confermPassword) async {
    var responce = await http.post(
      Uri.parse(resetPasswordPath),
      body: {
        "token": token,
        "password": password,
        "password_confirmation": confermPassword
      },
      headers: {
        "Accept": "application/json",
        "Accept-Language": langCode == '' ? "en" : langCode
      },
    );
    var data = json.decode(responce.body);
    if (responce.statusCode == 200) {
      return Future.value();
    } else {
      throw Exception(data['errors']['code']);
    }
  }
}
