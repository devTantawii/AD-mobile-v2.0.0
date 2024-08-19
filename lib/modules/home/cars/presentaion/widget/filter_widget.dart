import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/cars/presentaion/bloc/filter_cubit/filter_cubit.dart';
import 'package:abudiyab/modules/widgets/components/ad_colored_text_button.dart';
import 'package:abudiyab/service_locator.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion/motion.dart';

import '../all_cars_screen.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => sl<FilterCubit>()..getData(),
      child: BlocConsumer<FilterCubit, FilterState>(
        listener: (context, state) {
          if (state is FilterFailed) {
          }
        },
        builder: (context, state) {
          return Container(
            // constraints: BoxConstraints(maxHeight: size.height * 0.75),
            height: size.height * 0.75,
            width: size.width ,
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 350,
              width: 250,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xff6e9ed3),
                    blurRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      // height: size.height * 0.3,
                      width: size.width * 0.9,
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              locale!.category.toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Container(
                            // height: size.height * 0.3,
                            width: double.infinity,
                            padding: const EdgeInsets.all(5),
                            child: Wrap(
                              // scrollDirection: Axis.horizontal,
                              // shrinkWrap: true,
                              children: (state is FilterSuccess)
                                  ? state.categoryModel.data
                                      .map(
                                        (category) => ADColoredTextButton(
                                          onTap: () {
                                            context
                                                .read<FilterCubit>()
                                                .categoriesAddingHandler(
                                                    category.id.toString());
                                            print(context
                                                .read<FilterCubit>()
                                                .categories);
                                            print(category.id);
                                          },
                                          text: category.name ?? " ",
                                          isSelected: false,
                                        ),
                                      )
                                      .toList()
                                  : [],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.9,
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              locale.brand.toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Container(
                            // height: size.height * 0.3,
                            width: double.infinity,
                            padding: const EdgeInsets.all(5),
                            child: Wrap(
                              // scrollDirection: Axis.horizontal,
                              // shrinkWrap: true,
                              children: (state is FilterSuccess)
                                  ? state.manufactoriesModel.data!
                                      .map(
                                        (brand) => ADColoredTextButton(
                                          onTap: () {
                                            context
                                                .read<FilterCubit>()
                                                .brandsAddingHandler(
                                                    brand.id.toString());
                                            print(context
                                                .read<FilterCubit>()
                                                .brands);
                                            print(brand.id);
                                          },
                                          text: brand.name ?? " ",
                                          isSelected: false,
                                        ),
                                      )
                                      .toList()
                                  : [],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Motion(
                      child: Bounce(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => AllCarsScreen(fromFilter: true)));
                        },
                        child: Container(
                          height: size.height * 0.05,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              gradient: LinearGradient(colors: [
                                Color(0xff6e9ed3),
                                Color(0xff344CB7),
                              ])),
                          child: Center(
                              child: Text(
                            "Search",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
