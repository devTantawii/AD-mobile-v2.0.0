import 'package:abudiyab/modules/home/category/data/datasources/remote/category_remote_datasource.dart';
import 'package:abudiyab/modules/home/category/presentaion/bloc/cubit/category_cubit.dart';
import 'package:abudiyab/modules/home/category/presentaion/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfCategory extends StatefulWidget {
  const ListOfCategory({Key? key}) : super(key: key);

  @override
  State<ListOfCategory> createState() => _ListOfCategoryState();
}

class _ListOfCategoryState extends State<ListOfCategory> {
  late final CategoryRemotDataSource _categoryRemotDataSource;

  @override
  void initState() {
    _categoryRemotDataSource = CategoryRemotDataSource();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryCubit(_categoryRemotDataSource)..getDataCategory(),
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (State is CategoryInitial) {
            CategoryCubit.get(context).getDataCategory();
          }
        },
        builder: (context, state) {
          return Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              height: MediaQuery.of(context).size.height * 0.07,
              child: ListView.builder(
                  // padding: const EdgeInsets.symmetric(horizontal: 2.0),

                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: CategoryCubit.get(context)
                          .categoryModelData
                          ?.data
                          .length ??
                      0,
                  itemBuilder: (context, index) {
                    return CategoryItem(
                        data: CategoryCubit.get(context)
                            .categoryModelData!
                            .data[index]);
                  }),
            ),
          );
        },
      ),
    );
  }
}
