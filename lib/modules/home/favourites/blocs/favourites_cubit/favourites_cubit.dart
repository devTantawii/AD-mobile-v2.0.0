import 'package:abudiyab/modules/home/favourites/datasources/favourites_services.dart';
import 'package:abudiyab/modules/home/favourites/models/favourites.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(FavouritesInitial());

  getFavourites() async {
    emit(FavouritesLoading());
    try {
      final favourites = await FavouritesService.getFavourites();
      emit(FavouritesSuccess(favourites));
    } catch (error) {
      emit(FavouritesFailed(error.toString()));
    }
  }
}
