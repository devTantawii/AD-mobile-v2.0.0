import 'package:equatable/equatable.dart';

abstract class OldCustomerState extends Equatable {
  const OldCustomerState();
  @override
  List<Object> get props => [];
}

class OldCustomerInitial extends OldCustomerState {}

class ForgetLoading extends OldCustomerState {}

class ForgetLoaded extends OldCustomerState {}

class ForgetError extends OldCustomerState {
  final String error;
  ForgetError(this.error);
  @override
  List<Object> get props => [error];
}

class CodeLoading extends OldCustomerState {}

class CodeLoaded extends OldCustomerState {}

class CodeError extends OldCustomerState {
  final String error;
  CodeError(this.error);
  @override
  List<Object> get props => [error];
}

class ResetLoading extends OldCustomerState {}

class ResetLoaded extends OldCustomerState {}

class ResetError extends OldCustomerState {
  final String error;
  ResetError(this.error);
  @override
  List<Object> get props => [error];
}
