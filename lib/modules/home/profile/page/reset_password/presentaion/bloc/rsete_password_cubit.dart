import 'package:abudiyab/modules/home/profile/page/reset_password/datasources/remote/reset_password_datasources.dart';
import 'package:abudiyab/modules/home/profile/page/reset_password/presentaion/bloc/rsete_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RsetePasswordCubit extends Cubit<RsetePasswordState> {
  RsetePasswordCubit(this.resetPasswordDataSource)
      : super(RsetePasswordInitial());
  final ResetPasswordDataSource resetPasswordDataSource;

  Future rsetePassword({
    required String oldPassWord,
    required String newPassWord,
    required String confirmPassWord,
  }) async {
    await resetPasswordDataSource
        .resetPassword(
            oldPassWord: oldPassWord,
            newPassWord: newPassWord,
            confirmPassWord: confirmPassWord)
        .then(
          (value) => emit(
            RsetePasswordLoaded(),
          ),
        )
        .catchError(
          (e) => emit(
            RsetePassWordError(e.toString()),
          ),
        );
  }
}
