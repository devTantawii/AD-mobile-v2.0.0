import 'package:flutter_bloc/flutter_bloc.dart';


class OnBoardingCubit extends Cubit<bool> {
  OnBoardingCubit() : super(true);
  static OnBoardingCubit get(context) => BlocProvider.of(context);
  bool isLogin = true;
  void onChangeScreen() {
    isLogin = !isLogin;
    emit(!state);
  }
}
