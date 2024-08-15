import 'package:abudiyab/modules/home/cars/data/datasources/remote/cars_remote_datasource.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:abudiyab/modules/home/cars/presentaion/bloc/filter_cubit/filter_cubit.dart';
import 'package:abudiyab/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cars_state.dart';

class CarsCubit extends Cubit<CarsState> {
  CarsCubit(this.carsRemoteDataSource) : super(CarsInitial());

  final filterCubit = sl<FilterCubit>();

  static CarsCubit get(context) => BlocProvider.of(context);
  CarsRemoteDataSource carsRemoteDataSource;
  Cars? cars;

  Future<void> getAllCars(
    int pageNumber, {
    int? branchId,
    String? castClass,
    String? languageCode,
  }) async {
    emit(CarsLoding());
    try {
      if (pageNumber == 1) {
        cars = await carsRemoteDataSource.getAllCars(pageNumber,
            //availableOnly: true,
            branchId: branchId, castClass: castClass.toString());
      } else {
        final data = await carsRemoteDataSource.getAllCars(pageNumber,
            branchId: branchId, castClass: castClass.toString());
        cars?.data!.addAll(data.data!);
      }
      emit(CarsLoded());
    } catch (e) {
      emit(CarsLodError(e.toString()));
    }
  }


  Future<void> getCarsByFilter(int pageNumber, {int? branchId,}) async {
    emit(CarsLoding());
    try {
      final data = await carsRemoteDataSource.getCarsByFilter(
        pageNumber: pageNumber,
        manufactoryIds: filterCubit.brands,
        categoryIds: filterCubit.categories,
        model: filterCubit.modelYear,
        minPrice: filterCubit.minPrice,
        maxPrice: filterCubit.maxPrice,
       // available:  filterCubit.available,

      );
      cars?.data = data.data;
      emit(CarsLoded());
    } catch (e) {
      emit(CarsLodError(e.toString()));
    }
  }

  emitPhotoError(e) {
    emit(CarsImageLoadError(e.toString()));
  }
}
