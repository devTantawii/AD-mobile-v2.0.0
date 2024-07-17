import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:abudiyab/modules/home/cars/data/datasources/remote/favourite_remote_datasource.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavouriteRemoteDatasource favouriteRemoteDatasource;
  final SharedPreferencesHelper sharedPreferencesHelper;

  FavouriteCubit(this.favouriteRemoteDatasource, this.sharedPreferencesHelper)
      : super(FavouriteInitial());

  addToFavourites(String carID) async {
    try {
      final userToken = await sharedPreferencesHelper.getToken();
      await favouriteRemoteDatasource.addToFavourites(userToken , carID);
      emit(FavouriteSuccess());
      print('object add fav success');
    } catch (error) {
      emit(FavouriteError());
    }
  }
}
