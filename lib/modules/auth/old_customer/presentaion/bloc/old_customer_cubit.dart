import 'dart:developer';

import 'package:abudiyab/modules/auth/old_customer/datasources/code_remot_data_sources.dart';
import 'package:abudiyab/modules/auth/old_customer/datasources/forget_remot_data_sources.dart';
import 'package:abudiyab/modules/auth/old_customer/datasources/reset_remot_data_sources.dart';
import 'package:abudiyab/modules/auth/old_customer/presentaion/bloc/old_customer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OldCustomerCubit extends Cubit<OldCustomerState> {
  OldCustomerCubit(this.forgetRemotDataSources, this.codeRemotDataSources,
      this.resetRemotDataSources)
      : super(OldCustomerInitial());
  final ForgetRemotDataSources forgetRemotDataSources;
  final CodeRemotDataSources codeRemotDataSources;
  final ResetRemotDataSources resetRemotDataSources;
  String? token;
  Future<void> forgetOldCustomer(
      {required String phone, required String id}) async {
    emit(ForgetLoading());
    try {
      token =
          await forgetRemotDataSources.forgetOldCustomer(id: id, phone: phone);
      log(token.toString());
      emit(ForgetLoaded());
    } catch (e) {
      log(e.toString());
      emit(ForgetError(e.toString()));
    }
  }

  Future<void> enterodeOldCustomer({required String? code}) async {
    emit(CodeLoading());
    log(token.toString());
    try {
      await codeRemotDataSources.enterodeOldCustomer(code: code, token: token!);
      emit(CodeLoaded());
    } catch (e) {
      log(e.toString());
      emit(CodeError(e.toString()));
    }
  }

  Future<void> resetOldCustomer({
    required String? email,
    required String? password,
    required String? confPass,
  }) async {
    emit(ResetLoading());
    try {
      await resetRemotDataSources.resetOldCustomer(
          email: email, password: password, confPass: confPass, token: token!);
      emit(ResetLoaded());
    } catch (e) {
      log(e.toString());
      emit(ResetError(e.toString()));
    }
  }
}
