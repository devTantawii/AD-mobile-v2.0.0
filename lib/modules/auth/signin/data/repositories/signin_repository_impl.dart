import 'dart:async';

import 'package:abudiyab/modules/auth/signin/data/datasources/loacal/sigin_local_datasource.dart';
import 'package:abudiyab/modules/auth/signin/data/datasources/remote/signin_remote_datasource.dart';
import 'package:abudiyab/modules/auth/signin/data/models/signin_model.dart';
import 'package:abudiyab/modules/auth/signin/domain/repositories/signin_repository.dart';

class SignInRepositoryImpl extends SignInRepository {
  final SignInRemoteDataSourceImpl signInRemoteDataSource;
  final SignInLocalDataSourceImpl signInLocalDataSource;

  SignInRepositoryImpl(this.signInRemoteDataSource, this.signInLocalDataSource);

  @override
  Future<String?> loginUsingEmailAndPassword(SignInModel signInModel) async {
    try {
      final data =
          await signInRemoteDataSource.loginUsingEmailAndPassword(signInModel);
      // save data to local
      await signInLocalDataSource.saveToken(data!['token']);
      return data['token'];
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<String> forgetPassword(String phone) {
    throw UnimplementedError();
  }

  @override
  Future<bool> loginWithApple() => throw UnimplementedError();

  @override
  Future<bool> loginWithGoogle() => throw UnimplementedError();

  @override
  Future<String> postCode(String token, String code) =>
      throw UnimplementedError();

  @override
  Future<void> resetPassword(
          String token, String password, String confirmPassword) =>
      throw UnimplementedError();
}
