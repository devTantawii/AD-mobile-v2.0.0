part of 'all_cars_cubit.dart';

@immutable
abstract class AllCarsState extends Equatable {
  @override
  List<Object> get props => [];
}

class AllCarsInitial extends AllCarsState {}


class AllCarsLoding extends AllCarsState {}

class AllCarsLoded extends AllCarsState {}

class AllCarsLodError extends AllCarsState {
  final String error;

  AllCarsLodError(this.error);
}

class CarsImageLoadError extends AllCarsState {
  final String error;

  CarsImageLoadError(this.error);

  @override
  List<Object> get props => [error];
}
