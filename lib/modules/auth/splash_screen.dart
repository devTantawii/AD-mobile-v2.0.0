import 'package:abudiyab/modules/auth/signin/presentation/pages/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:abudiyab/modules/home/profile/blocs/profile_cubit/profile_cubit.dart';
import 'package:abudiyab/modules/compose_ui.dart';

import '../../core/helpers/SharedPreference/pereferences.dart';
import '../home/all_bookings/presentaion/bloc/allbooking_cubit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Widget startWidget;

  @override
  void initState() {
    super.initState();
    initializeScreen();
  }

  void initializeScreen() async {
    // Fetch profile data
    BlocProvider.of<ProfileCubit>(context).getProfile();

    // Check for token and fetch bookings if available
    String? token = SharedPreferencesHelper().get("token")?.toString();
    if (token != null) {
      await BlocProvider.of<AllBookingCubit>(context).getAllBooking(state: 'running');
      startWidget = const ComposeUi();
    } else {
      startWidget = const SignInScreen();
    }

    // Navigate after delay
    Future.delayed(
      const Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => startWidget),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          Theme.of(context).brightness == Brightness.light
              ? "assets/images/splash.gif"
              : "assets/images/darkSplash.gif",
          gaplessPlayback: true,
        ),
      ),
    );
  }
}
