import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:abudiyab/modules/home/cars/presentaion/page/cars_info.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:abudiyab/modules/widgets/components/error_image.dart';
import 'package:abudiyab/shared/style/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

import 'blocs/favourites_cubit/favourites_cubit.dart';

class Favourites extends StatefulWidget {
  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  late bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var locale = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => FavouritesCubit()..getFavourites(),
      child: BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(locale.favourites!.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 16.sp)),
              leading: ADBackButton(),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await BlocProvider.of<FavouritesCubit>(context).getFavourites();
              },
              child: Container(
                child: state is FavouritesSuccess
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: state.favourites.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  pushNewScreen(context,
                                      screen: CarsInformation(
                                        datum: DataCars.fromMap(
                                            state.favourites[index].toMap()),
                                      ));
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  padding: EdgeInsets.only(
                                      top: 0,
                                      right: MediaQuery.of(context).size.width * 0.02,
                                      left: MediaQuery.of(context).size.width * 0.02,),
                                  margin: EdgeInsets.symmetric(
                                      vertical: 0.sp, horizontal: 0.sp),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Theme.of(context).colorScheme.primaryContainer
                                        : null,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        state.favourites[index].photo
                                            .toString(),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                      ),
                                      FittedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.favourites[index].name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary),
                                            ),
                                            GestureDetector(
                                                onTap: () async {
                                                  await showTopModalSheet(
                                                      context,
                                                      Container(
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .secondaryContainer
                                                            : Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.85,
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              vertical: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.06,
                                                              horizontal:
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.05),
                                                          child: Container(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .stretch,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  locale
                                                                      .lookLike1
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                Text(
                                                                  locale
                                                                      .lookLike
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .onPrimary),
                                                                ),
                                                                SizedBox(
                                                                  height: 10.sp,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ));
                                                },
                                                child: Icon(Icons.info_outline,
                                                    size: 16.sp)),
                                            SizedBox(
                                              width: 3.sp,
                                            ),
                                            FittedBox(
                                                child: Text(
                                              locale.lookLike1.toString(),
                                              style: TextStyle(fontSize: 14.sp),
                                            )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        child: Row(
                                          children: [
                                            carIconInfo(
                                                "assets/images/transmission.png",
                                                "${state.favourites[index].transmission!.replaceAll('ناقل حركة أوتوماتيكي', 'أوتوماتيك')}"),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: Container(
                                                height: 23.sp,
                                                width: 1,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
                                            ),
                                            carIconInfo(
                                                "assets/images/seat.png",
                                                "${state.favourites[index].luggage}"),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: Container(
                                                height: 23.sp,
                                                width: 1,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
                                            ),
                                            carIconInfo(
                                                "assets/images/car-door.png",
                                                "${state.favourites[index].doors}"),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        width: double.infinity,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Color(0xff323376)
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0.sp),
                                                child: Row(
                                                  children: [
                                                    Text.rich(
                                                      TextSpan(
                                                        text:
                                                            "${state.favourites[index].priceAfter} ",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onPrimary),
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                "${state.favourites[index].priceBefore}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontSize:
                                                                      16.sp,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "  ${locale.sar}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .copyWith(
                                                                    color: Theme.of(context).brightness ==
                                                                            Brightness
                                                                                .light
                                                                        ? Theme.of(context)
                                                                            .colorScheme
                                                                            .primary
                                                                        : Colors
                                                                            .white),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "/ ${locale.day}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium!
                                                                .copyWith(
                                                                    color: Color(
                                                                        0xffF08A61),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Center(
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                kPrimaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        child: Icon(
                                                          Icons.arrow_forward,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 25.sp,
                                    top: MediaQuery.of(context).size.height *
                                        0.028),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: Color(0xffF08A61),
                                      size: 25.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : state is FavouritesLoading
                        ? Center(
                            child: CircularProgressIndicator.adaptive(
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                          ))
                        : ErrorImage(
                            refresh: () {
                              BlocProvider.of<FavouritesCubit>(context)
                                  .getFavourites();
                            },
                          ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget carIconInfo(image, text) => Row(
        children: [
          SizedBox(
              height: 18.sp,
              child: Image.asset(
                image,
                color: Color(0xffF08A61),
              )),
          SizedBox(
            width: 5.0.sp,
          ),
          AutoSizeText(
            "$text",
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
}
