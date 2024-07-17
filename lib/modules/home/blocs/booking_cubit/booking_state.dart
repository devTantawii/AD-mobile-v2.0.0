part of 'booking_cubit.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class PaymentMethodChanged extends BookingState {
  final String? method;

  PaymentMethodChanged(this.method);

  @override
  List<Object> get props => [method ?? ""];
}

class CouponValid extends BookingState {
  final CouponModel couponModel;

  CouponValid(this.couponModel);
  @override
  List<Object> get props => [couponModel];
}

class CouponLoading extends BookingState {}

class CouponInvalid extends BookingState {
  final String? message;

  CouponInvalid(this.message);

  @override
  List<Object> get props => [message ?? ""];
}
