part of 'signin_bloc.dart';

@immutable
abstract class SignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignIn extends SignInEvent {
  final String email;
  final String password;
  final String device_token;

  SignIn({required this.email, required this.password,required this.device_token});
  @override
  List<Object> get props => [email, password,device_token];

}
class ShowPasswordEvent extends SignInEvent{}