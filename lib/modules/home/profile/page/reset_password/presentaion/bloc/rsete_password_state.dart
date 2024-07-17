import 'package:equatable/equatable.dart';

abstract class RsetePasswordState extends Equatable {
  const RsetePasswordState();
  @override
  List<Object> get props => [];
}

class RsetePasswordInitial extends RsetePasswordState {}

class RsetePasswordLoading extends RsetePasswordState {}

class RsetePasswordLoaded extends RsetePasswordState {}

class RsetePassWordError extends RsetePasswordState {
  final String error;
  RsetePassWordError(this.error);
  @override
  List<Object> get props => [error];
}
