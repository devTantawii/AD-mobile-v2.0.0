import 'package:abudiyab/modules/home/cars/data/datasources/remote/manufactories_remote_datasource.dart';
import 'package:abudiyab/modules/home/cars/data/models/manufactories_Model.dart';
import 'package:abudiyab/modules/home/category/data/datasources/remote/category_remote_datasource.dart';
import 'package:abudiyab/modules/home/category/data/models/category_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final ManufactoriesRemoteDataSource manufactoriesRemoteDataSource;
  final CategoryRemotDataSource categoryRemotDataSource;

  FilterCubit(this.manufactoriesRemoteDataSource, this.categoryRemotDataSource)
      : super(FilterInitial());
  List<String> brands = [];
  List<String> categories = [];
  List<String> modelYear = [];
  // int? modelYear = 0;
  int? minPrice = 0;
  int? maxPrice = 3230;

  getData() async {
    emit(FilterLoading());
    try {
      final mauData = await manufactoriesRemoteDataSource.getManufactories();
      final catData = await categoryRemotDataSource.getCategory();
      emit(FilterSuccess(mauData, catData));
    } catch (e) {
      print(e);
      emit(FilterFailed(e.toString()));
    }
  }

  void brandsAddingHandler(String id) {
    if (brands.contains(id)) {
      brands.remove(id);
    } else {
      brands.add(id);
    }
  }

  void categoriesAddingHandler(String id) {
    if (categories.contains(id)) {
      categories.remove(id);
    } else {
      categories.add(id);
    }
  }

  // void modelAdditionHandler(int model) {
  //   if (modelYear != model) {
  //     modelYear = model;
  //   } else
  //     modelYear = 0;
  // }

  void modelAddingHandler(String model, context) {
    if (modelYear.contains(model)) {
      modelYear.remove(model);
    } else{
      modelYear.add(model);
    }
  }
}
