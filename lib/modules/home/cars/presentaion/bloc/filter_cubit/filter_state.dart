part of 'filter_cubit.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilterInitial extends FilterState {}

class FilterLoading extends FilterState {}

class FilterSuccess extends FilterState {
  final Manufactories manufactoriesModel;
  final CategoryModelData categoryModel;

  FilterSuccess(this.manufactoriesModel, this.categoryModel);

  @override
  List<Object> get props => [this.manufactoriesModel, this.categoryModel];
}

class FilterFailed extends FilterState {
  final String error;

  FilterFailed(this.error);

  @override
  List<Object> get props => [error];
}
