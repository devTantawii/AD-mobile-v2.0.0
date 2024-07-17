import 'dart:async';

import 'package:abudiyab/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:abudiyab/modules/auth/signin/data/models/signin_model.dart';
import 'package:abudiyab/modules/auth/signin/data/repositories/signin_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInRepositoryImpl signInRepository;
  final AuthBloc authBloc;

  SignInBloc(this.authBloc,  this.signInRepository)
      : super(SignInInitial()) {
    on<SignIn>(_onSignInEvent);
  }

  FutureOr<void> _onSignInEvent(SignIn event, Emitter<SignInState> emit,) async {
    emit(SignInLoading());
    final userData = SignInModel(email: event.email, password: event.password,device_token: event.device_token);
    try {
      final token = await signInRepository.loginUsingEmailAndPassword(userData);
      if (token != null /*&& userData.custClass.toString().isNotEmpty*/) {
        emit(SignInSuccess());
         print(event.device_token.toString()+'ddddddd');
      } else {
        emit(SignInFailure(error: '..Oops'));
      }
    } catch (e) {
      emit(SignInFailure(error: e.toString()));
    }
  }
}
