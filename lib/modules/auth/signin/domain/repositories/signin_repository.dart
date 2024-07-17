import 'package:abudiyab/modules/auth/signin/data/models/signin_model.dart';

abstract class SignInRepository {
  Future<String?> loginUsingEmailAndPassword(SignInModel signInModel);

  Future<bool> loginWithGoogle();

  Future<bool> loginWithApple();

  Future<String> forgetPassword(String phone);

  Future<String> postCode(String token, String code);

  Future<void> resetPassword(String token, String password, String confirmPassword);
}
