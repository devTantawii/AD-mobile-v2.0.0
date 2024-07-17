part of 'favourite_cubit.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}
class FavouriteSuccess extends FavouriteState {}
class FavouriteError extends FavouriteState {}
