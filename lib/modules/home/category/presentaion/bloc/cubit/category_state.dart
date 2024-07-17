part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoding extends CategoryState {}

class CategoryLoded extends CategoryState {
  final CategoryModelData categoryModel;

  CategoryLoded(this.categoryModel);

  @override
  List<Object> get props => [categoryModel];
}

class CategoryErorr extends CategoryState {
  final String message;

  CategoryErorr(this.message);
  @override
  List<Object> get props => [message];
}
