// import 'dart:developer';
//
// import 'package:abudiyab/modules/home/all_bookings/data/datasources/booking_automation_data_sources.dart';
// import 'package:abudiyab/modules/home/all_bookings/data/datasources/cancel_booking_automation_data_sources.dart';
// import 'package:abudiyab/modules/home/all_bookings/data/model/booking_automation_model.dart';
// import 'package:bloc/bloc.dart';
//
// import 'booking_automation_state.dart';
//
// class BookingAutomationCubit extends Cubit<BookingAutomationState> {
//   BookingAutomationCubit(this.bookingAutomationDataSources,
//       this.cancelBookingAutomationDataSources)
//       : super(BookingAutomationInition());
//
//   final BookingAutomationDataSources bookingAutomationDataSources;
//   final CancelBookingAutomationDataSources cancelBookingAutomationDataSources;
//
//   Future getBookingAutomation() async {
//     emit(BookingAutomationLoading());
//     try {
//       final BookingAutomationModel booking =
//           await bookingAutomationDataSources.getBookingAutomation();
//
//       emit(BookingAutomationLoaded(bookingAutomationModel: booking));
//     } catch (e) {
//       emit(BookingAutomationError(error: e.toString()));
//     }
//   }
//
//   Future<void> cancelBooking({required int orderId}) async {
//     emit(CancelBookingAutomationLoading());
//     try {
//       await cancelBookingAutomationDataSources.cancelBookingAutomation(
//           orderId: orderId);
//       emit(CancelBookingAutomationSuccess());
//     } catch (e) {
//       log(e.toString());
//       emit(CancelBookingAutomationError(error: e.toString()));
//     }
//   }
// }
