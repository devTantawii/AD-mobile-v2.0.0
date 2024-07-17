import 'package:abudiyab/modules/home/profile/blocs/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/helpers/SharedPreference/pereferences.dart';
import '../auth/signin/presentation/pages/signin_screen.dart';
import '../compose_ui.dart';
import 'all_bookings/presentaion/bloc/allbooking_cubit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  double value = 0;
  late Widget startWidget;
  String? token = SharedPreferencesHelper().get("token").toString();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getProfile();
    token!=null?BlocProvider.of<AllBookingCubit>(context).getAllBooking(state: 'running'):false;
    if (token != null) {
      startWidget = const ComposeUi();
    } else {
      startWidget = const SignInScreen();
    }
    Future.delayed(
        const Duration(seconds: 3),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => startWidget),
        ));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              Theme.of(context).brightness==Brightness.light?
              "assets/images/splash.gif":"assets/images/darkSplash.gif",
              gaplessPlayback: true,
            )));
  }
}


