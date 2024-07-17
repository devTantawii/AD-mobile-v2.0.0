import 'dart:convert';

import 'package:abudiyab/modules/home/cars/data/datasources/remote/cars_remote_datasource.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:abudiyab/modules/home/cars/presentaion/bloc/filter_cubit/filter_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../service_locator.dart';

part 'all_cars_state.dart';

class AllCarsCubit extends Cubit<AllCarsState> {
  AllCarsCubit(this.carsRemoteDataSource) : super(AllCarsInitial());
  final filterCubit = sl<FilterCubit>();

  static AllCarsCubit get(context) => BlocProvider.of(context);

  CarsRemoteDataSource carsRemoteDataSource;
  Cars? cars;

  Future<void> getAllCars(
      int pageNumber,
      {int? branchId, String ?castClass,}) async {
    emit(AllCarsLoding());
    try {
      if (pageNumber == 1) {
        cars = await carsRemoteDataSource.getAllCars(pageNumber,
            branchId: branchId,
          castClass: castClass
        );
      } else {
        final data = await carsRemoteDataSource.getAllCars(pageNumber,
            branchId: branchId,
          castClass: castClass
        );
        cars?.data!.addAll(data.data!);
      }
      emit(AllCarsLoded());
    } catch (e) {
      emit(AllCarsLodError(e.toString()));
    }
  }

  Future<void> getCarsByFilter(int pageNumber, {
    int? branchId,
    String ?customerClass,
  }) async {
    emit(AllCarsLoding());
    try {
      final data = await carsRemoteDataSource.getCarsByFilter(
        pageNumber: pageNumber,
        manufactoryIds: filterCubit.brands,
        categoryIds: filterCubit.categories,
        model: filterCubit.modelYear,
        minPrice: filterCubit.minPrice,
        maxPrice: filterCubit.maxPrice,
        customerClass: customerClass,
      );

      if (pageNumber == 1) {
         cars?.data = data.data;
      } else {
        cars?.data?.addAll(data.data!);
      }
      emit(AllCarsLoded());
    } catch (e) {
      emit(AllCarsLodError(e.toString()));
    }
  }

  emitPhotoError(e) {
    emit(CarsImageLoadError(e.toString()));
  }
}
