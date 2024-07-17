import 'package:abudiyab/modules/auth/forgotPassword/data/datasources/forget_password_data_sourse.dart';
import 'package:abudiyab/modules/auth/forgotPassword/presentaion/bloc/forget_password.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.forgetPasswordDataSourse)
      : super(ForgetPasswordInitial());

  final ForgetPasswordDataSourse forgetPasswordDataSourse;

  Future sendPone({required String phone}) async {
    emit(ForgetPasswordLoading());
    await forgetPasswordDataSourse
        .forgetPassword(phone: phone)
        .then((value) => emit(ForgetPasswordLoaded()))
        .catchError((e) {
      emit(ForgetPassWordError(e.toString()));
    });
  }

  Future sendCode({required String code}) async {
    emit(CodeLoading());
    await forgetPasswordDataSourse
        .postCode(code)
        .then(
          (value) => emit(
            CodeLoaded(),
          ),
        )
        .catchError(
          (e) => emit(
            CodeError(
              e.toString(),
            ),
          ),
        );
  }

  Future passwordchange(
      {required String password, required String confirmPassword}) async {
    emit(ChangePasswordLoading());
    await forgetPasswordDataSourse
        .resetPassword(password, confirmPassword)
        .then(
          (value) => emit(
            ChangePasswordLoaded(),
          ),
        )
        .catchError(
          (e) => emit(
            ChangePassWordError(e.toString()),
          ),
        );
  }
}
