part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {
  final String massage;

  RegisterError(this.massage);

  @override
  List<Object> get props => [massage];
}

class ShowPassword extends RegisterState {}

class ImageProfileLodingState extends RegisterState {}

class ImageProfileScussesState extends RegisterState {}

class ImageProfileErrorState extends RegisterState {
  final String error;

  ImageProfileErrorState({
    required this.error,
  });
}
