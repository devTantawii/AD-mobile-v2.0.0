import 'dart:async';
import 'dart:io';
import 'package:abudiyab/core/helpers/enums.dart';
import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/cars/presentaion/bloc/cubit/cars_cubit.dart';
import 'package:abudiyab/modules/home/cars/presentaion/cars_screan.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_cubit.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_state.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/filter_model.dart';
import 'package:abudiyab/modules/home/search_screen/presentaion/widget/card_top_headlines.dart';
import 'package:abudiyab/modules/home/search_screen/presentaion/widget/classic_rent_body.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../widgets/components/countdown_widget.dart';
import '../../../widgets/components/dateRange.dart';
import '../../all_branching/bloc/all_branching_cubit.dart';
import '../../cars/presentaion/all_cars_screen.dart';
import '../../profile/blocs/profile_cubit/profile_cubit.dart';
import '../blocs/headlines_bloc/headlines_cubit.dart';

class SearchScreen extends StatefulWidget {
  int showAlertOffer;

  SearchScreen({
    Key? key,
    this.showAlertOffer = 1,
  }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchScreen> {
  bool? isAlertboxOpened;
  bool? isAlertboxOpenedz = false;

  final targetDate = DateTime(2024, 9, 23);
  Timer? timer;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  void initState() {
    isAlertboxOpened = true;
    BlocProvider.of<AllBranchCubit>(context).getAllBranch();
    BlocProvider.of<ProfileCubit>(context).getProfile();
    getOffers();
    getRegions();

    super.initState();
  }

  //getBranches() async => await BlocProvider.of<SearchCubit>(context).getBranches();
  getRegions() async =>
      await BlocProvider.of<SearchCubit>(context).getRegions();

  getOffers() async => await BlocProvider.of<SearchCubit>(context).getOffers();

  // getAllBooking() async =>  BlocProvider.of<AllBookingCubit>(context).getAllBooking(state: 'running');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) async {
          ///-----------When Offers Day ------------------
          // if (widget.showAlertOffer == 1) {
          //   DateRangeWidget(
          //       startDate: DateTime(2024, 9, 18),
          //       endDate: DateTime(2024, 9, 23),
          //       child: showOffersDay(
          //           context, CountdownTimerWidget(targetDate: targetDate)));
          //   setState(() {
          //     widget.showAlertOffer = 0;
          //   });
          // }

          ///-----------When Offers Day ------------------
          if (BlocProvider.of<SearchCubit>(context).message == '1' &&
              isAlertboxOpened == true &&
              isAlertboxOpenedz == false) {
            isAlertboxOpenedz = true;
            showAlert(
              context,
              Text(
                locale!.offersDisc.toString() +
                    BlocProvider.of<SearchCubit>(context)
                        .discountValue
                        .toString() +
                    '%' +
                    locale.offersNow.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.primary),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  locale.offersDialogBox.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            );
          }
          if (state is SearchInvalid) {
            HelperFunctions.dialog(
                context: context,
                title: locale!.dateInvalid,
                body: state.props.first.toString());
          } else if (state is SearchValidate) {
            final triggeredBranchModel = context
                .read<SearchCubit>()
                .branchesData
                .where((element) =>
                    element.name ==
                    BlocProvider.of<SearchCubit>(context).selectedReceiveBranch)
                .first;
            final filterModel = FilterModel(
              selectedBranch: triggeredBranchModel,
              receiveTimeValue: BlocProvider.of<SearchCubit>(context)
                  .receiveTimeValue
                  .hour
                  .toString(),
              driveTimeValue: BlocProvider.of<SearchCubit>(context)
                  .driveTimeValue
                  .hour
                  .toString(),
              receiveDateValue: BlocProvider.of<SearchCubit>(context)
                  .receiveDateValue
                  .toString(),
              driveDateValue: BlocProvider.of<SearchCubit>(context)
                  .driveDateValue
                  .toString(),
            );
            await BlocProvider.of<CarsCubit>(context)
                .getAllCars(1,
                    branchId: triggeredBranchModel.id,
                    castClass: BlocProvider.of<ProfileCubit>(context)
                        .custClass
                        .toString())
                .then((value) => PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: CarsScreen(filterModel: filterModel)));
          } else if (state is SearchCheckLoading) {
            HelperFunctions.showFlashBar(
                context: context,
                title: locale!.loading,
                message: locale.pleaseWaitWhileLoading,
                icon: FontAwesomeIcons.infoCircle,
                color: Theme.of(context).colorScheme.secondaryContainer,
                iconColor: Theme.of(context).colorScheme.primary,
                titlcolor: Theme.of(context).colorScheme.primary);
          }
        },
        builder: (context, state) {
          if (state is SearchLoading) {
            return Center(
                child: CircularProgressIndicator.adaptive(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
            ));
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<HeadlinesCubit>(context).getDataSlider();
                getRegions();
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 180.h, child: CardTopHeadlines()),
                    Container(
                      height: size.height * 0.6,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 20.h),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.5),
                                    blurRadius: 1,
                                    offset: const Offset(0, -2),
                                  ),
                                ],
                              ),
                              child: context.read<SearchCubit>().rentType ==
                                      RentType.classic
                                  ? ClassicRentBody()
                                  : Container(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  ///----------------------------
  showAlert(BuildContext context, Widget text, Widget text2) {
    showDialog(
        context: context,
        builder: (context) => Stack(
              children: [
                Container(
                  child: Positioned(
                    top: MediaQuery.of(context).size.height / 3,
                    left: MediaQuery.of(context).size.width / 17,
                    right: MediaQuery.of(context).size.width / 17,
                    child: AlertDialog(
                      title: text2,
                      content: text,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                    right: MediaQuery.of(context).size.width / 2.3,
                    top: MediaQuery.of(context).size.height / 3,
                    child: Center(
                      child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/offers.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          )),
                    )),
              ],
            ));
  }

  ///------------اليوم الوطني
  showOffersDay(BuildContext context, Widget header) async {
    await showDialog(
      context: context,
      builder: (context) => Stack(
        children: [
          AlertDialog(
            contentPadding: EdgeInsets.zero,
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0.sp),
              child: header,
            ),
            backgroundColor: Colors.white,
            content: Builder(
              builder: (context) {
                var height = MediaQuery.of(context).size.height * 0.6;
                var width = MediaQuery.of(context).size.width;
                return Container(
                  height: height,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      height: height,
                      autoPlay: true,
                      viewportFraction: 1.0,
                      disableCenter: true,
                      enableInfiniteScroll: true,
                    ),
                    items: [
                      'assets/images/app1.jpg',
                      'assets/images/app2.jpg',
                      'assets/images/app3.jpg',
                    ].map((item) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllCarsScreen(
                                fromFilter: false,
                                filterModel: null,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.zero,
                          width: width * 0.8,
                          height: height,
                          child: Image.asset(item, fit: BoxFit.cover),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
          Positioned(
            right: Platform.isIOS
                ? MediaQuery.of(context).size.width * 0.12
                : MediaQuery.of(context).size.width * 0.12,
            top: Platform.isIOS
                ? MediaQuery.of(context).size.height * 0.11
                : MediaQuery.of(context).size.height * 0.13,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(40.sp),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.close,
                    size: 17.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
