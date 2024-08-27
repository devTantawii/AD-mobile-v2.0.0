import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/cars/presentaion/bloc/filter_cubit/filter_cubit.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:abudiyab/modules/widgets/components/ad_colored_text_button.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../../../service_locator.dart';
import '../all_cars_screen.dart';

class FiltersCars extends StatefulWidget {
  const FiltersCars({Key? key}) : super(key: key);

  @override
  State<FiltersCars> createState() => _FiltersCarsState();
}

class _FiltersCarsState extends State<FiltersCars>
    with SingleTickerProviderStateMixin {
  var tabControler;
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  @override
  void initState() {
    tabControler = TabController(length: 3, vsync: this);
    geData();
    super.initState();
  }

  List<String> years = [
    "2024",
    "2023",
    "2022",
    "2021",
  ];

  geData() async => await sl<FilterCubit>().getData();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale!.filterCars.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        leading: ADBackButton(),
      ),
      body: BlocConsumer<FilterCubit, FilterState>(
        listener: (context, state) {
          if (state is FilterFailed) {
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.035),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.isDirectionRTL(context)?"السعر":"Price",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16.sp,fontWeight: FontWeight.w600),
                      ),
                      Text(
                          "${context.read<FilterCubit>().minPrice} - "
                              "${context.read<FilterCubit>().maxPrice}"+locale.sar.toString(),
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onPrimary,),
                      ),
                    ],
                  ),
                  Container(
                    child: RangeSlider(
                      inactiveColor: Colors.grey[300],
                      values: _currentRangeValues,
                      max: 10000,
                      activeColor: Theme.of(context).colorScheme.onPrimary,
                      labels: RangeLabels(
                        _currentRangeValues.start.round().toString(),
                        _currentRangeValues.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValues = values;
                          context.read<FilterCubit>().minPrice =
                              values.start.toInt();
                          context.read<FilterCubit>().maxPrice =
                              values.end.toInt();
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  Row(
                    children: [
                      Text(
                        locale.selectModel,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16.sp,fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Wrap(
                    // scrollDirection: Axis.horizontal,
                    // shrinkWrap: true,
                      children:
                      years
                          .map(
                            (year) => ADColoredTextButton(
                            onTap: () {
                              context
                                  .read<FilterCubit>()
                                  .modelAddingHandler(
                                  year.toString(),context
                              );
                              // print(context
                              //     .read<FilterCubit>()
                              //     .modelYear);
                            },
                            text: year ?? "",
                            isSelected: context.read<FilterCubit>().modelYear.contains(year.toString())

                        ),
                      ).toList()
                    ///---------------
                    ///children: (state is FilterSuccess)
                    //                             ? state.manufactoriesModel.data!
                    //                                 .map(
                    //                                   (brand) => ADColoredTextButton(
                    //                                     onTap: () {
                    //                                       context
                    //                                           .read<FilterCubit>()
                    //                                           .brandsAddingHandler(
                    //                                               brand.id.toString());
                    //                                       print(context.read<FilterCubit>().brands);
                    //                                       print(brand.id);
                    //                                     },
                    //                                     text: brand.name ?? " ",
                    //                                     isSelected: context
                    //                                         .read<FilterCubit>()
                    //                                         .brands
                    //                                         .contains(brand.id.toString()),
                    //                                   ),
                    //                                 )
                    //                                 .toList()
                    //                             : [],
                    //                       ),
                    //                     ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        locale.isDirectionRTL(context)?"فئة السيارة":"Vehicle class",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16.sp,fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Wrap(
                    children: (state is FilterSuccess)
                        ? state.categoryModel.data
                        .map(
                          (category) => ADColoredTextButton(
                        onTap: () {
                          context.read<FilterCubit>().categoriesAddingHandler(category.id.toString());
                        },
                        text: category.name ?? " ",
                        isSelected: context
                            .read<FilterCubit>()
                            .categories
                            .contains(category.id.toString()),
                      ),
                    )
                        .toList()
                        : [],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        locale.brand.toString(),
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16.sp,fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Wrap(
                    children: (state is FilterSuccess)
                        ? state.manufactoriesModel.data!
                        .map(
                          (brand) => ADColoredTextButton(
                        onTap: () {
                          context
                              .read<FilterCubit>()
                              .brandsAddingHandler(
                              brand.id.toString());
                          print(context.read<FilterCubit>().brands);
                          print(brand.id);
                        },
                        text: brand.name ?? " ",
                        isSelected: context
                            .read<FilterCubit>()
                            .brands
                            .contains(brand.id.toString()),
                      ),
                    )
                        .toList()
                        : [],
                  ),
                  SizedBox(
                    height:MediaQuery.of(context).size.height*0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(context, screen: AllCarsScreen(fromFilter: true));
                    },
                    child: ADGradientButton(locale.search),
                  ),
                  SizedBox(
                    height:MediaQuery.of(context).size.height*0.14,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
