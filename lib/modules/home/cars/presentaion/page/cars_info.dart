import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/auth/signin/presentation/pages/signin_screen.dart';
import 'package:abudiyab/modules/home/additions/presentaion/blocs/addition_cubit/additions_cubit.dart';
import 'package:abudiyab/modules/home/additions/presentaion/pages/additions_screen.dart';
import 'package:abudiyab/modules/home/blocs/favourite_cubit/favourite_cubit.dart';
import 'package:abudiyab/modules/home/booking_from_cars/presentaion/view/branchs_with_car_screan.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:abudiyab/modules/home/cars/presentaion/widget/car_icon_info.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/filter_model.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:abudiyab/shared/style/colors.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:widget_zoom/widget_zoom.dart';

import '../../../../../core/helpers/helper_fun.dart';
import 'image_car_page.dart';

class CarsInformation extends StatefulWidget {
  CarsInformation(
      {Key? key, required this.datum, this.filterModel, this.stockStatus})
      : super(key: key);

  final DataCars? datum;
  final FilterModel? filterModel;
  final String? stockStatus;

  @override
  State<CarsInformation> createState() => _CarsInformationState();
}

class _CarsInformationState extends State<CarsInformation> {
  late bool isFavorite;

  bool? lookLike = true;

  @override
  void initState() {
    isFavorite = widget.datum!.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: ADBackButton(),
        title: Text(
          locale!.isDirectionRTL(context) ? "تفاصيل السيارة" : "Car Details",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<FavouriteCubit>(context)
                  .addToFavourites(widget.datum!.id.toString());
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: isFavorite
                ? Icon(
                    Icons.favorite,
                    color: Theme.of(context).colorScheme.secondary,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 1,
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                if (widget.stockStatus != null)
                                  SizedBox(
                                    height: 40,
                                  ),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: WidgetZoom(
                                        heroAnimationTag: 'tag',
                                        zoomWidget: Image.network(widget.datum!.photo)),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            child: Row(
                                              children: [
                                                Text(
                                                    widget.datum!.name +
                                                        " ${locale.lookLike1.toString()}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onPrimary,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                SizedBox(
                                                  width: 6.sp,
                                                ),
                                                Row(
                                                  children: [
                                                    // GestureDetector(
                                                    //     onTap: () async {
                                                    //       await showTopModalSheet(
                                                    //           context,
                                                    //           Container(
                                                    //             color: Theme.of(
                                                    //                     context)
                                                    //                 .colorScheme
                                                    //                 .secondaryContainer,
                                                    //             width: MediaQuery.of(
                                                    //                         context)
                                                    //                     .size
                                                    //                     .width *
                                                    //                 0.85,
                                                    //             child: Padding(
                                                    //               padding: EdgeInsets.symmetric(
                                                    //                   vertical: MediaQuery.of(context)
                                                    //                           .size
                                                    //                           .height *
                                                    //                       0.06,
                                                    //                   horizontal: MediaQuery.of(context)
                                                    //                           .size
                                                    //                           .width *
                                                    //                       0.05),
                                                    //               child:
                                                    //                   Container(
                                                    //                 child:
                                                    //                     Column(
                                                    //                   mainAxisAlignment:
                                                    //                       MainAxisAlignment
                                                    //                           .spaceEvenly,
                                                    //                   crossAxisAlignment:
                                                    //                       CrossAxisAlignment
                                                    //                           .stretch,
                                                    //                   children: <Widget>[
                                                    //                     Text(
                                                    //                       widget.datum!.name.toString().toUpperCase() +
                                                    //                           ' ' +
                                                    //                           locale.lookLike1.toString(),
                                                    //                       style: Theme.of(context)
                                                    //                           .textTheme
                                                    //                           .labelLarge!
                                                    //                           .copyWith(color: kPrimaryColor),
                                                    //                     ),
                                                    //                     Text(
                                                    //                       locale
                                                    //                           .lookLike
                                                    //                           .toString(),
                                                    //                       style: TextStyle(
                                                    //                           fontSize: 15.sp,
                                                    //                           fontWeight: FontWeight.w500,
                                                    //                           color: Theme.of(context).colorScheme.primary),
                                                    //                     ),
                                                    //                   ],
                                                    //                 ),
                                                    //               ),
                                                    //             ),
                                                    //           ));
                                                    //     },
                                                    //     child: Icon(
                                                    //         Icons.info_outline,
                                                    //         size: 16.sp),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  text:
                                                      "${widget.datum!.priceAfter} ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          fontSize: 26.sp),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "${widget.datum!.priceBefore}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                            fontSize: 26,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontWeight:
                                                                FontWeight.w100,
                                                          ),
                                                    ),
                                                    TextSpan(
                                                      text: " ${locale.sar}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary),
                                                    ),
                                                    TextSpan(
                                                      text: "/${locale.day}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (widget.stockStatus != null)
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      locale.isDirectionRTL(context) ? "نفذت الكميه" : "Out of Stock",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.datum!.photos!.length,
                          itemBuilder: (context, index) {
                            return Bounce(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        ImageCarPage(
                                            photo: widget.datum!.photos!),
                                  ),
                                );
                              },
                              child: Card(
                                margin: const EdgeInsets.all(10.0),
                                elevation: 8.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          widget.datum!.photos![index].url!),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CarIconInfo(
                          image: "assets/images/car-door.png",
                          text: "${widget.datum!.doors}"),
                      CarIconInfo(
                          image: "assets/images/seat.png",
                          text: "${widget.datum!.luggage}"),
                      CarIconInfo(
                          image: "assets/images/transmission.png",
                          text: "${widget.datum!.transmission}"),
                    ],
                  )),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05),
                      margin: const EdgeInsets.all(1),
                      child: Text(
                        "${widget.datum!.description}",
                        maxLines: 5,
                        overflow: TextOverflow.visible,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 14.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: MediaQuery.of(context).size.width * 0.05),
                      child: Bounce(
                        onTap: () {
                          if (widget.filterModel == null) {
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen: BranchWithCarScreen(
                                    carModel: widget.datum!));
                          } else {
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen: AdditionsScreen(
                                  datum:
                                      widget.datum, /*fromNotCompleted: false,*/
                                ));
                          }
                        },
                        child:  Bounce(
                            onTap: () {
                          
                              if (widget.stockStatus != null) {
                                Fluttertoast.showToast(
                                  msg:   locale.isDirectionRTL(context) ? "السيارة غير متاحه حاليا. استمتع معنا بتجربه اخرى" : "Stock status is not available.Enjoy another experience.",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.redAccent.shade400,
                                  textColor: Colors.white,
                                  fontSize: 14.sp,
                                );
                                return;
                              }
                          
                              // Proceed with showing the dialog if stockStatus is null
                          
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        widget.datum!.name
                                                .toString()
                                                .toUpperCase() +
                                            ' ' +
                                            locale.lookLike1.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Cairo'),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      backgroundColor: Theme.of(context)
                                                  .brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : Theme.of(context).colorScheme.primary,
                                      content: Container(
                                        child: Text(
                                          locale.lookLike.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                      actions: [
                                        BlocConsumer<AdditionsCubit,
                                            AdditionsState>(
                                          listener: (context, state) {
                                            if (state is AdditionsFailed) {
                                              HelperFunctions.showFlashBar(
                                                context: context,
                                                title: state.error.contains(
                                                        "Error Please LOGIN To Continue")
                                                    ? locale.loginToContinue
                                                        .toString()
                                                    : state.error
                                                        .toString()
                                                        .replaceAll(
                                                            "message: Error During Communication. -> Details: Exception:",
                                                            ''),
                                                message: '',
                                                icon: Icons.info,
                                                color: Color(0xffF6A9A9),
                                                titlcolor: Colors.red,
                                                iconColor: Colors.red,
                                              );
                                              if (state.error.contains(
                                                  "Error Please LOGIN To Continue")) {
                                                navigateAndFinish(
                                                    context, SignInScreen());
                                              }
                                            }
                                          },
                                          builder: (context, state) {
                                            return Bounce(
                                              onTap: () async {
                                                await BlocProvider.of<
                                                        AdditionsCubit>(context)
                                                    .getCarFeatures(
                                                        context,
                                                        widget.datum!.id
                                                            .toString());
                                                if (widget.filterModel == null &&
                                                    lookLike == true) {
                                                  PersistentNavBarNavigator.pushNewScreen(context,
                                                      screen: BranchWithCarScreen(
                                                          carModel:
                                                              widget.datum!));
                                                } else {
                                                  Navigator.pop(context);
                                                  if (state is AdditionsSuccess ||
                                                      state is AdditionsInitial) {
                                                    PersistentNavBarNavigator.pushNewScreen(context,
                                                        screen: AdditionsScreen(
                                                          datum: widget.datum,
                                                        ));
                                                  }
                                                  if (state is AdditionsFailed) {
                                                    HelperFunctions.showFlashBar(
                                                      context: context,
                                                      message: state.error.contains(
                                                              "Error Please LOGIN To Continue")
                                                          ? locale.loginToContinue
                                                              .toString()
                                                          : state.error
                                                              .toString()
                                                              .replaceAll(
                                                                  "message: Error During Communication. -> Details: Exception:",
                                                                  ''),
                                                      title:
                                                          locale.error.toString(),
                                                      icon: Icons.info,
                                                      color: Color(0xffF6A9A9),
                                                      titlcolor: Colors.red,
                                                      iconColor: Colors.red,
                                                    );
                                                    if (state.error.contains(
                                                        "Error Please LOGIN To Continue")) {
                                                      navigateAndFinish(context,
                                                          SignInScreen());
                                                    }
                                                  }
                                                }
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  state is AdditionsLoading
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator
                                                                  .adaptive(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onPrimary,
                                                        ))
                                                      : Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.08,
                                                            vertical: 8.sp,
                                                          ),
                                                          child: Text(
                                                            locale.ok.toString(),
                                                            style:
                                                                Theme.of(context)
                                                                    .textTheme
                                                                    .bodyLarge,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: ADGradientButton(locale.bookNow),
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
    );
  }
}
