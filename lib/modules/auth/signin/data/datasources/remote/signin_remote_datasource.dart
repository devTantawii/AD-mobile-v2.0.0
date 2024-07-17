import 'dart:convert';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:abudiyab/modules/auth/signin/data/models/signin_model.dart';
import 'package:dio/dio.dart';

abstract class SignInRemoteDataSource {
  Future<Map<String,dynamic>?> loginUsingEmailAndPassword(SignInModel signInModel);

  Future<bool> loginWithGoogle();

  Future<bool> loginWithApple();

  Future<String> forgetPassword(String phone);

  Future<String> postCode(String token, String code);

  Future<void> resetPassword(
      String token, String password, String confirmPassword);
}

class SignInRemoteDataSourceImpl extends SignInRemoteDataSource {
  final Dio _dio = Dio();

  @override
  Future<Map<String,dynamic>?> loginUsingEmailAndPassword(SignInModel signInModel) async {
    try {
      final Response response = await _dio.post(mainApi + loginApi,
          options: Options(responseType: ResponseType.plain ,headers: {"Accept": "application/json"}),

          data: signInModel.toMap());
      final  decodedData =  json.decode(response.data) as Map<String,dynamic>;
      return decodedData;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }

  @override
  Future<String> forgetPassword(String phone) {
    throw UnimplementedError();
  }

  @override
  Future<String> postCode(String token, String code) =>
      throw UnimplementedError();

  @override
  Future<void> resetPassword(String token, String password, String confirmPassword) =>
      throw UnimplementedError();

  @override
  Future<bool> loginWithApple() => throw UnimplementedError();

  @override
  Future<bool> loginWithGoogle() => throw UnimplementedError();
}
