import 'dart:io';
import 'package:abudiyab/modules/home/splash_screen.dart';
import 'package:abudiyab/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/app_life_cycle_manager.dart';
import 'core/constants/langCode.dart';
import 'core/init_app.dart';
import 'core/style/style.dart';
import 'language/languageCubit.dart';
import 'language/locale.dart';
import 'modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'modules/auth/forgotPassword/presentaion/bloc/forget_password_cubit.dart';
import 'modules/auth/old_customer/presentaion/bloc/old_customer_cubit.dart';
import 'modules/home/additions/presentaion/blocs/addition_cubit/additions_cubit.dart';
import 'modules/home/all_bookings/presentaion/bloc/allbooking_cubit.dart';
import 'modules/home/all_bookings/presentaion/bloc/booking_automation_cubit/booking_automation_cubit.dart';
import 'modules/home/all_branching/bloc/all_branching_cubit.dart';
import 'modules/home/blocs/booking_cubit/booking_cubit.dart';
import 'modules/home/blocs/favourite_cubit/favourite_cubit.dart';
import 'modules/home/cars/presentaion/bloc/all_cars_cubit/all_cars_cubit.dart';
import 'modules/home/cars/presentaion/bloc/cubit/cars_cubit.dart';
import 'modules/home/cars/presentaion/bloc/filter_cubit/filter_cubit.dart';
import 'modules/home/payment/blocs/invoice_cubit.dart';
import 'modules/home/profile/blocs/profile_cubit/profile_cubit.dart';
import 'modules/home/search_screen/blocs/headlines_bloc/headlines_cubit.dart';
import 'modules/home/search_screen/blocs/search_bloc/search_cubit.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await InitializeApp.run();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
    statusBarColor:  Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ),
  );
  ///----------------StartFirebase Code -------------------
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      name: 'abudiyab',
      options: const FirebaseOptions(
        apiKey: "AIzaSyCec8SdOopL4_byJ6_113JfaLyL_1VKFm0",
        appId: "1:1092780024078:ios:6274a163218d2a9ba4375f",
        messagingSenderId: "1092780024078",
        projectId: "abudiyab-ab965",
      ),
    );
    firebaseMessaging.requestPermission(
      alert:true,
      announcement:false,
      badge:true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }else{
    await Firebase.initializeApp();
  }
  await Future.delayed(Duration(seconds:2));
  //String ? fireToken;
  if(Platform.isIOS){
    await Future<void>.delayed(
      const Duration(seconds: 3,),
    );
    await FirebaseMessaging.instance.getAPNSToken().then((value) {
      deviceToken = value;
    });
  }else{
    await FirebaseMessaging.instance.getToken().then((value) {
      deviceToken = value;
    });
  }
  FirebaseMessaging.onMessage.listen((event) {});
  FirebaseMessaging.onMessageOpenedApp.listen((event) {}
  );
  ///----------------- END Firebase Code -----------------
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {

    super.initState();
  }

  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, widget) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>()),
              BlocProvider<CarsCubit>(create: (context) => sl<CarsCubit>()),
              BlocProvider<BookingCubit>(
                  create: (context) => sl<BookingCubit>()),
              BlocProvider<LanguageCubit>(
                  create: (context) => sl<LanguageCubit>()),
              BlocProvider<ForgetPasswordCubit>(
                  create: (context) => sl<ForgetPasswordCubit>()),
              BlocProvider<ProfileCubit>(
                  create: (context) => sl<ProfileCubit>()),
              BlocProvider<AdditionsCubit>(
                  create: (context) => sl<AdditionsCubit>()),
              BlocProvider<InvoiceCubit>(
                  create: (context) => sl<InvoiceCubit>()),
              BlocProvider<FavouriteCubit>(
                  create: (context) => sl<FavouriteCubit>()),
              BlocProvider<SearchCubit>(create: (context) => sl<SearchCubit>()),
              BlocProvider<FilterCubit>(create: (context) => sl<FilterCubit>()),
              BlocProvider<HeadlinesCubit>(
                  create: (context) => sl<HeadlinesCubit>()..getDataSlider()),
              BlocProvider<OldCustomerCubit>(
                  create: (context) => sl<OldCustomerCubit>()),
              BlocProvider<AllBookingCubit>(
                  create: (context) => sl<AllBookingCubit>()),
              BlocProvider<AllBranchCubit>(
                  create: (context) => sl<AllBranchCubit>()),
              BlocProvider<AllCarsCubit>(
                  create: (context) => sl<AllCarsCubit>()),
              BlocProvider<AdditionsCubit>(
                  create: (context) => sl<AdditionsCubit>()),
              // BlocProvider(create: (context) => sl<BookingAutomationCubit>()),
            ],
            child: BlocBuilder<LanguageCubit, Locale>(
              builder: (_, locale) {
                return AppLifeCycleManager(
                  child: MaterialApp(
                    localizationsDelegates: [
                      const AppLocalizationsDelegate(),
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    supportedLocales: const [Locale('en'), Locale('ar')],
                    locale: locale,
                    theme: lightTheme(),
                    // darkTheme: darkTheme(),
                    themeMode: ThemeMode.system,
                    home: SplashScreen(),
                    debugShowCheckedModeBanner: false,
                  ),
                );
              },
            ),
          );
        });
  }
}
