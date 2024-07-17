part of 'cars_cubit.dart';

abstract class CarsState extends Equatable {
  const CarsState();

  @override
  List<Object> get props => [];
}

class CarsInitial extends CarsState {}

class CarsLoding extends CarsState {}

class CarsLoded extends CarsState {}

class CarsLodError extends CarsState {
  final String error;

  CarsLodError(this.error);
}

class CarsImageLoadError extends CarsState {
  final String error;

  CarsImageLoadError(this.error);
  @override
  List<Object> get props => [error];
}
