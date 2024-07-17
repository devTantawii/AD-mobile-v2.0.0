import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_cubt_state.dart';

class OnBoardingCubit extends Cubit<bool> {
  OnBoardingCubit() : super(true);
  static OnBoardingCubit get(context) => BlocProvider.of(context);
  bool isLogin = true;
  void onChangeScreen() {
    isLogin = !isLogin;
    emit(!state);
  }
}
