part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class AuthChanged extends AuthEvent {
  AuthChanged(this.token);

  final dynamic token;

  @override
  List<Object> get props => [token != null];
}

class LoggedOut extends AuthEvent {}
