// import 'dart:convert';
//
// import 'package:abudiyab/core/constants/api_path.dart';
// import 'package:abudiyab/core/constants/langCode.dart';
// import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
// import 'package:abudiyab/core/helpers/exception/exceptions.dart';
// import 'package:abudiyab/modules/home/all_bookings/data/model/booking_automation_model.dart';
// import 'package:dio/dio.dart';
//
// class BookingAutomationDataSources {
//   SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper();
//   Future<BookingAutomationModel> getBookingAutomation() async {
//     final token = await sharedPreferencesHelper.getToken();
//     try {
//       final Dio dio = Dio();
//
//       final Response response = await dio.get(
//         bookingAutomationPath,
//         options: Options(responseType: ResponseType.plain, headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token",
//           "Accept-Language": langCode == '' ? "en" : langCode,
//         }),
//       );
//       print("response : ${response.statusCode}");
//       final dataOrders = json.decode(response.data);
//       final BookingAutomationModel bookingAutomationModel =
//           BookingAutomationModel.fromMap(dataOrders);
//       return bookingAutomationModel;
//     } on DioError catch (dioError) {
//       throw Failure.fromDioError(dioError);
//     } catch (error) {
//       throw '..Oops $error';
//     }
//   }
// }
