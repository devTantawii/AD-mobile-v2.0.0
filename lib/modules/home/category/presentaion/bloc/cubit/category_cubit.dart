import 'package:abudiyab/modules/home/category/data/datasources/remote/category_remote_datasource.dart';
import 'package:abudiyab/modules/home/category/data/models/category_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.categoryRemotDataSource) : super(CategoryInitial());
  static CategoryCubit get(context) => BlocProvider.of(context);

  CategoryRemotDataSource categoryRemotDataSource;
  CategoryModelData? categoryModelData;
  void getDataCategory() async {
    emit(CategoryLoding());
    try {
      categoryModelData = await categoryRemotDataSource.getCategory();
      emit(CategoryLoded(categoryModelData!));
    } catch (e) {
      emit(CategoryErorr(e.toString()));
    }
  }
}
