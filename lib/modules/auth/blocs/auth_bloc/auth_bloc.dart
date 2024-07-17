import 'dart:async';

import 'package:abudiyab/core/constants/preferences_constants.dart';
import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SharedPreferencesHelper preferences ;

  AuthBloc(this.preferences) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedOut>(_onLoggedOut);
    on<AuthChanged>(_onAuthChanged);
    add(AppStarted());
    {}
    // _auth.authState.listen((user) {
    //   add(AuthChanged(user));
    // });
  }

  FutureOr<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) {
    // unawaited(_auth.signOut());
    emit(Unauthenticated());
    add(AuthChanged(null));
  }

  FutureOr<void> _onAuthChanged(AuthChanged event, Emitter<AuthState> emit) {
    emit(event.token != null ? Authenticated() : Unauthenticated());
  }

  FutureOr<void> _onAppStarted(
      AppStarted event, Emitter<AuthState> emit) async {
    final token = await preferences.get(PreferencesConstants.token);
    if (token != null) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }
}
