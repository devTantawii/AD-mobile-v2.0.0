import 'package:equatable/equatable.dart';

abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();
  @override
  List<Object> get props => [];
}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordLoaded extends ForgetPasswordState {}

class ForgetPassWordError extends ForgetPasswordState {
  final String error;
  ForgetPassWordError(this.error);
  @override
  List<Object> get props => [error];
}

class CheckTokenLoading extends ForgetPasswordState {}

class CheckTokenLoaded extends ForgetPasswordState {}
class CheckTokenError extends ForgetPasswordState {
  final String error;
  CheckTokenError(this.error);
  @override
  List<Object> get props => [error];
}

class CodeLoading extends ForgetPasswordState {}

class CodeLoaded extends ForgetPasswordState {}

class CodeError extends ForgetPasswordState {
  final String error;
  CodeError(this.error);
  @override
  List<Object> get props => [error];
}

class ChangePasswordLoading extends ForgetPasswordState {}

class ChangePasswordLoaded extends ForgetPasswordState {}

class ChangePassWordError extends ForgetPasswordState {
  final String error;
  ChangePassWordError(this.error);
  @override
  List<Object> get props => [error];
}
