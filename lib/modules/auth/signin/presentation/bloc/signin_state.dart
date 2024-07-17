part of 'signin_bloc.dart';

@immutable
abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  // final SignInModel signInModel;
  // SignInSuccess(this.signInModel);
}

class SignInFailure extends SignInState {
  final String error;

  SignInFailure({required this.error});

  @override
  List<Object> get props => [error];
}
class ShowPassword extends SignInState{}