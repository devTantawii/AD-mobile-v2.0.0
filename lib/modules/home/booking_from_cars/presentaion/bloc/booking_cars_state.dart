import 'package:abudiyab/modules/home/booking_from_cars/model/branch_from_cars_model.dart';
import 'package:equatable/equatable.dart';

abstract class BookingFromCarsState extends Equatable {
  BookingFromCarsState();
  @override
  List<Object> get props => [];
}

class BookingFromCarsInitial extends BookingFromCarsState {}

class BookingFromCarsLoading extends BookingFromCarsState {}

class BookingFromCarsLoaded extends BookingFromCarsState {
  final BranchFromCarModel branchModel;
  BookingFromCarsLoaded({required this.branchModel});
  @override
  List<Object> get props => [branchModel];
}

class BookingFromCarsError extends BookingFromCarsState {
  final String error;
  BookingFromCarsError({required this.error});
  @override
  List<Object> get props => [error];
}
