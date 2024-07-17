part of 'favourites_cubit.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object> get props => [];
}

class FavouritesInitial extends FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesSuccess extends FavouritesState {
  final List<Favorite> favourites;

  FavouritesSuccess(this.favourites);

  @override
  List<Object> get props => [favourites];
}

class FavouritesFailed extends FavouritesState {
  final String error;

  FavouritesFailed(this.error);

  @override
  List<Object> get props => [error];
}
