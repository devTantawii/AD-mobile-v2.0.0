import 'package:abudiyab/modules/home/all_bookings/data/model/booking_model.dart';
import 'package:equatable/equatable.dart';


abstract class AllBookingState extends Equatable {
  const AllBookingState();
  @override
  List<Object> get props => [];
}

class AllBookingInition extends AllBookingState {}

class AllBookingLoading extends AllBookingState {}

class AllBookingLoaded extends AllBookingState {
  final Booking booking;
  AllBookingLoaded({required this.booking});
  @override
  List<Object> get props => [booking];
}

class AllBookingError extends AllBookingState {
  final String error;
  AllBookingError({required this.error});
  @override
  List<Object> get props => [error];
}

class CancelLoading extends AllBookingState {}

class CancelSuccess extends AllBookingState {}

class CancelError extends AllBookingState {
  final String error;
  CancelError({required this.error});
  @override
  List<Object> get props => [error];
}
class DeleteOrderLoading extends AllBookingState {}

class DeleteOrderSuccess extends AllBookingState {}

class DeleteOrderError extends AllBookingState {
  final String error;
  DeleteOrderError({required this.error});
  @override
  List<Object> get props => [error];
}
