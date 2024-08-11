import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/app_life_cycle_manager.dart';
import 'core/style/style.dart';
import 'language/languageCubit.dart';
import 'language/locale.dart';
import 'modules/auth/old_customer/presentaion/bloc/old_customer_cubit.dart';
import 'modules/auth/splash_screen.dart';
import 'service_locator.dart';
import 'modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'modules/auth/forgotPassword/presentaion/bloc/forget_password_cubit.dart';
import 'modules/home/additions/presentaion/blocs/addition_cubit/additions_cubit.dart';
import 'modules/home/all_bookings/presentaion/bloc/allbooking_cubit.dart';
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

MultiBlocProvider CreateBlocProviders(BuildContext context) {
  return MultiBlocProvider(
    providers: [

      BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>()),
      BlocProvider<CarsCubit>(create: (context) => sl<CarsCubit>()),
      BlocProvider<BookingCubit>(create: (context) => sl<BookingCubit>()),
      BlocProvider<LanguageCubit>(create: (context) => sl<LanguageCubit>()),
      BlocProvider<ForgetPasswordCubit>(create: (context) => sl<ForgetPasswordCubit>()),
      BlocProvider<ProfileCubit>(create: (context) => sl<ProfileCubit>()),
      BlocProvider<AdditionsCubit>(create: (context) => sl<AdditionsCubit>()),
      BlocProvider<InvoiceCubit>(create: (context) => sl<InvoiceCubit>()),
      BlocProvider<FavouriteCubit>(create: (context) => sl<FavouriteCubit>()),
      BlocProvider<SearchCubit>(create: (context) => sl<SearchCubit>()),
      BlocProvider<FilterCubit>(create: (context) => sl<FilterCubit>()),
      BlocProvider<HeadlinesCubit>(create: (context) => sl<HeadlinesCubit>()..getDataSlider()),
      BlocProvider<OldCustomerCubit>(create: (context) => sl<OldCustomerCubit>()),
      BlocProvider<AllBookingCubit>(create: (context) => sl<AllBookingCubit>()),
      BlocProvider<AllBranchCubit>(create: (context) => sl<AllBranchCubit>()),
      BlocProvider<AllCarsCubit>(create: (context) => sl<AllCarsCubit>()),
      BlocProvider<AdditionsCubit>(create: (context) => sl<AdditionsCubit>()),
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
}
