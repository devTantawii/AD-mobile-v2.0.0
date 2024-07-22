import 'dart:developer';

import 'package:abudiyab/modules/home/all_bookings/data/datasources/booking_data_sources.dart';
import 'package:abudiyab/modules/home/all_bookings/data/datasources/cancel_booking_data_sources.dart';
import 'package:abudiyab/modules/home/all_bookings/data/model/booking_model.dart';
import 'package:abudiyab/modules/home/all_bookings/presentaion/bloc/allbooking_state.dart';
import 'package:bloc/bloc.dart';


class AllBookingCubit extends Cubit<AllBookingState> {
  AllBookingCubit(this.bookingDataSources, this.cancelBookingDataSources,
      )
      : super(AllBookingInition());
  final BookingDataSources bookingDataSources;
  // final BookingAutomationDataSources bookingAutomationDataSources;
  final CancelBookingDataSources cancelBookingDataSources;

  Booking? booking;
  Future getAllBooking({required String state}) async {

    emit(AllBookingLoading());
    try {
       booking = await bookingDataSources.getAllBooking(status: state);
      emit(AllBookingLoaded(booking: booking!));
       print(booking!.data!.toString()+'777');
    } catch (e) {
      print(e.toString());
      emit(AllBookingError(error: e.toString()));
    }
  }

  Future<void> cancelBooking({required int orderId}) async {
    emit(CancelLoading());
    try {
      await cancelBookingDataSources.cancelBooking(orderId: orderId);
      emit(CancelSuccess());
    } catch (e) {
      log(e.toString());
      emit(CancelError(error: e.toString()));
    }
  }
  Future<void> deleteBooking({required int orderId}) async {
    emit(DeleteOrderLoading());
    try {
      await cancelBookingDataSources.deleteBooking(orderId: orderId);
      emit(DeleteOrderSuccess());
    } catch (e) {
      emit(DeleteOrderError(error: e.toString()));
    }
  }

}
