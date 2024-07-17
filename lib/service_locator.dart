import 'package:abudiyab/core/helpers/date_helper.dart';
import 'package:abudiyab/modules/auth/forgotPassword/data/datasources/forget_password_data_sourse.dart';
import 'package:abudiyab/modules/auth/forgotPassword/presentaion/bloc/forget_password_cubit.dart';
import 'package:abudiyab/modules/auth/old_customer/datasources/code_remot_data_sources.dart';
import 'package:abudiyab/modules/auth/old_customer/datasources/forget_remot_data_sources.dart';
import 'package:abudiyab/modules/auth/old_customer/datasources/reset_remot_data_sources.dart';
import 'package:abudiyab/modules/auth/old_customer/presentaion/bloc/old_customer_cubit.dart';
import 'package:abudiyab/modules/auth/onboarding/bloc/onboarding_cubt_cubit.dart';
import 'package:abudiyab/modules/auth/register/presentaion/bloc/register_cubit.dart';
import 'package:abudiyab/modules/auth/signin/presentation/bloc/signin_bloc.dart';

import 'package:abudiyab/modules/home/all_bookings/data/datasources/booking_data_sources.dart';
import 'package:abudiyab/modules/home/all_bookings/data/datasources/cancel_booking_data_sources.dart';
import 'package:abudiyab/modules/home/all_branching/bloc/all_branching_cubit.dart';
import 'package:abudiyab/modules/home/all_branching/data/all_branching_remote_datasource.dart';
import 'package:abudiyab/modules/home/booking_from_cars/datasources/booking_cars_remote_datasource.dart';
import 'package:abudiyab/modules/home/booking_from_cars/presentaion/bloc/booking_cars_cubit.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/headlines_bloc/headlines_cubit.dart';
import 'package:abudiyab/modules/home/search_screen/data/datasources/remote/headlines_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/helpers/SharedPreference/pereferences.dart';
import 'language/languageCubit.dart';
import 'modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'modules/auth/register/data/datasources/local/register_local_datasources.dart';
import 'modules/auth/register/data/datasources/remote/register_remote_datasource.dart';
import 'modules/auth/signin/data/datasources/loacal/sigin_local_datasource.dart';
import 'modules/auth/signin/data/datasources/remote/signin_remote_datasource.dart';
import 'modules/auth/signin/data/repositories/signin_repository_impl.dart';

import 'modules/home/additions/data/datasource/remote/order_addition_remote_datasource.dart';
import 'modules/home/additions/data/repositories/addition_repository.dart';
import 'modules/home/additions/presentaion/blocs/addition_cubit/additions_cubit.dart';
import 'modules/home/all_bookings/data/datasources/booking_automation_data_sources.dart';
import 'modules/home/all_bookings/data/datasources/cancel_booking_automation_data_sources.dart';
import 'modules/home/all_bookings/data/datasources/edit_order_remote_datasource.dart';
import 'modules/home/all_bookings/presentaion/bloc/allbooking_cubit.dart';
import 'modules/home/all_bookings/presentaion/bloc/booking_automation_cubit/booking_automation_cubit.dart';
import 'modules/home/all_bookings/presentaion/bloc/edit_order_cubit/edit_order_cubit.dart';
import 'modules/home/blocs/booking_cubit/booking_cubit.dart';
import 'modules/home/blocs/favourite_cubit/favourite_cubit.dart';
import 'modules/home/cars/data/datasources/remote/cars_remote_datasource.dart';
import 'modules/home/cars/data/datasources/remote/favourite_remote_datasource.dart';
import 'modules/home/cars/data/datasources/remote/manufactories_remote_datasource.dart';
import 'modules/home/cars/presentaion/bloc/all_cars_cubit/all_cars_cubit.dart';
import 'modules/home/cars/presentaion/bloc/cubit/cars_cubit.dart';
import 'modules/home/cars/presentaion/bloc/filter_cubit/filter_cubit.dart';
import 'modules/home/category/data/datasources/remote/category_remote_datasource.dart';
import 'modules/home/payment/blocs/invoice_cubit.dart';
import 'modules/home/payment/data/datasources/remote/coupon_remote_datasource.dart';
import 'modules/home/payment/data/datasources/remote/invoice_remote_datasource.dart';
import 'modules/home/payment/data/datasources/remote/payment_remote_datasource.dart';
import 'modules/home/payment/data/repositories/coupon_repository.dart';
import 'modules/home/payment/data/repositories/invoice_repository.dart';
import 'modules/home/payment/data/repositories/payment_repository.dart';
import 'modules/home/profile/blocs/profile_cubit/profile_cubit.dart';
import 'modules/home/profile/page/all_member_ship/bloc/all_member_ship_cubit.dart';
import 'modules/home/profile/page/all_member_ship/data/all_member_ship_remot.dart';
import 'modules/home/profile/page/edit_profile/datasources/remote/edit_remote_dataSource.dart';
import 'modules/home/profile/page/edit_profile/presentaion/bloc/edit_profile_cubit.dart';
import 'modules/home/profile/page/reset_password/datasources/remote/reset_password_datasources.dart';
import 'modules/home/profile/page/reset_password/presentaion/bloc/rsete_password_cubit.dart';
import 'modules/home/search_screen/blocs/search_bloc/search_cubit.dart';
import 'modules/home/search_screen/data/datasources/remote/areas_remote_datasource.dart';
import 'modules/home/search_screen/data/datasources/remote/check_date_remote.dart';
import 'modules/home/search_screen/data/datasources/remote/regions_remote_datasource.dart';

GetIt sl = GetIt.instance;

Future<void> setup() async {
  // Blocs
  sl.registerFactory(() => AuthBloc(sl()));
  sl.registerFactory(() => SignInBloc(sl(), sl()));
  sl.registerFactory(() => RegisterCubit(sl()));
  sl.registerFactory(() => OnBoardingCubit());
  sl.registerLazySingleton(() => BookingCubit(sl()));
  sl.registerLazySingleton(() => LanguageCubit(sl()));
  sl.registerFactory(() => CarsCubit(sl()));
  sl.registerLazySingleton(() => FilterCubit(sl(), sl()));
  sl.registerLazySingleton(() => SearchCubit(sl(), sl(), sl()));
  sl.registerFactory(() => AdditionsCubit(sl(), sl(),AllBookingCubit(sl(), sl(),),sl()));
  sl.registerFactory(() => EditProfileCubit(sl()));
  sl.registerFactory(() => RsetePasswordCubit(sl()));
  sl.registerFactory(() => ForgetPasswordCubit(sl()));
  sl.registerFactory(() => AllBookingCubit(sl(), sl(),));
  sl.registerFactory(() => ProfileCubit(sl()));
  sl.registerFactory(() => InvoiceCubit(sl(), sl(), sl(), sl(),));
  sl.registerFactory(() => FavouriteCubit(sl(), sl()));
  sl.registerFactory(() => EditOrderCubit(sl()));
  sl.registerFactory(() => HeadlinesCubit(sl()));
  sl.registerFactory(() => AllBranchCubit(sl()));
  sl.registerFactory(() => BookingFromCarsCubit(sl()));
  sl.registerFactory(() => OldCustomerCubit(sl(), sl(), sl()));
  sl.registerFactory(() => AllMemberCubit(sl()));
  sl.registerFactory(() => AllCarsCubit(sl()));


  // Repositories
  sl.registerLazySingleton(() => SignInRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => AdditionRepository(sl(), sl()));
  sl.registerLazySingleton(() => InvoiceRepository(sl(), sl()));
  sl.registerLazySingleton(() => PaymentRepository(sl(), sl()));
  sl.registerLazySingleton(() => CouponRepository(sl(), sl()));


  // DataSources
  sl.registerLazySingleton(() => SignInRemoteDataSourceImpl());
  sl.registerLazySingleton(() => SignInLocalDataSourceImpl(sl()));
  sl.registerLazySingleton(() => RegisterRemoteDatasource());
  sl.registerLazySingleton(() => RegisterLocalDataSourceImpl(sl()));
  sl.registerLazySingleton(() => CarsRemoteDataSource(sl(), sl()));
  sl.registerLazySingleton(() => ManufactoriesRemoteDataSource());
  sl.registerLazySingleton(() => CategoryRemotDataSource());
  sl.registerLazySingleton(() => OrderAdditionsRemoteDatasource());
  sl.registerLazySingleton(() => EditProfileDataSource());
  sl.registerLazySingleton(() => ResetPasswordDataSource());
  sl.registerLazySingleton(() => ForgetPasswordDataSourse());
  sl.registerLazySingleton(() => BookingDataSources());
  sl.registerLazySingleton(() => InvoiceRemoteDatasource());
  sl.registerLazySingleton(() => DateCheckerRemote());
  sl.registerLazySingleton(() => PaymentRemoteDatasource());
  sl.registerLazySingleton(() => FavouriteRemoteDatasource(sl()));
  sl.registerLazySingleton(() => RegionsRemoteDatasource(sl()));
  sl.registerLazySingleton(() => HeadlinesRemoteDataSource());
  sl.registerLazySingleton(() => AllBranchRemoteDataSource());
  sl.registerLazySingleton(() => BookingFromCarsRemoteDataSource());
  sl.registerLazySingleton(() => CancelBookingDataSources(sl(), sl()));
  sl.registerLazySingleton(() => CouponRemoteDatasource(sl()));
  sl.registerLazySingleton(() => EditOrderRemoteDatasource(sl(), sl()));
  sl.registerLazySingleton(() => ForgetRemotDataSources());
  sl.registerLazySingleton(() => CodeRemotDataSources());
  sl.registerLazySingleton(() => ResetRemotDataSources());
  sl.registerLazySingleton(() => AllMemberShipRemoteDataSource());
  sl.registerLazySingleton(() => AreasRemoteDatasource(sl()));



  // External
  sl.registerLazySingleton(() => SharedPreferencesHelper());
  sl.registerLazySingleton(() => DateHandler());
  sl.registerLazySingleton(() => Dio());
}
