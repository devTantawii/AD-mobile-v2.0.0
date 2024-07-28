import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_cubit.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_state.dart';
import 'package:abudiyab/modules/home/search_screen/presentaion/widget/region_tile.dart';
import 'package:abudiyab/modules/home/search_screen/presentaion/widget/select_day_and_time.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:abudiyab/shared/style/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helpers/SharedPreference/pereferences.dart';
import '../../../all_branching/bloc/all_branching_cubit.dart';
import '../../../all_branching/data/models/branch_model.dart';
import '../../../profile/blocs/profile_cubit/profile_cubit.dart';
import 'map_list_selection_view_tile.dart';

class ClassicRentBody extends StatefulWidget {
  const ClassicRentBody({Key? key}) : super(key: key);

  @override
  State<ClassicRentBody> createState() => _ClassicRentBodyState();
}

class _ClassicRentBodyState extends State<ClassicRentBody> {
  late bool searchError = false;
  bool _switchValue = false;
  int listIndex = 0;
  String? token = SharedPreferencesHelper().get("token").toString();
  late final List<BranchModel>? branches;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context);
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locale!.choseBranch.toString(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 18.sp,
                          color: Theme.of(context).brightness ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                        ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: RegionTile(
                        regions:
                            BlocProvider.of<SearchCubit>(context).regionsData),
                  ),
                  BlocProvider.of<SearchCubit>(context).branchesData.isNotEmpty
                      ? MapListSelectionViewTile(
                          branches: context.read<SearchCubit>().branchesData,
                          areas: context.read<SearchCubit>().areasData,
                          isAutomated: false,
                          isReceive: true)
                      : SizedBox.shrink(),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: BlocProvider.of<SearchCubit>(context)
                                .branchesData
                                .isNotEmpty
                            ? AutoSizeText(
                                locale.deliverAnotherBranch.toString(),
                                style: Theme.of(context).textTheme.labelLarge)
                            : Container(),
                      ),
                      BlocProvider.of<SearchCubit>(context)
                              .branchesData
                              .isNotEmpty
                          ? SizedBox(
                              child: FittedBox(
                                child: Switch.adaptive(
                                  activeColor: kPickColor,
                                  value: _switchValue,
                                  onChanged: (value) => setState(() {
                                    _switchValue = value;
                                  }),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  _switchValue
                      ? MapListSelectionViewTile(
                          isAutomated: false,
                          branches: context.read<AllBranchCubit>().branchesData,
                          areas: context.read<SearchCubit>().areasData,
                          isReceive: false)
                      : SizedBox(),
                  _switchValue ? SizedBox(height: 5) : SizedBox(),
                  SizedBox(height: 15.h),
                  Text(
                    locale.selectDateAndTime.toString(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 18.sp,
                          color: Theme.of(context).brightness ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,

                        ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Container(
                        height: Device.get().isTablet ? 220.h : 170.h,
                        width: 147.w,
                        child: SelectDayAndTimeWidget(isReceive: true),
                      ),
                      Spacer(),
                      Container(
                        height: Device.get().isTablet ? 220.h : 170.h,
                        width: 147.w,
                        child: SelectDayAndTimeWidget(isReceive: false),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Device.get().isTablet ? 100 : 0,
                  ),
                  GestureDetector(
                    onTap: () => onTap(context),
                    child: ADGradientButton(locale.search),
                  ),
                  Text(
                    searchError ? locale.selectRegionAndBranch : "",
                    style: TextStyle(
                        color: Colors.red[300],
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  onTap(BuildContext context) async {
    try {
      print(BlocProvider.of<SearchCubit>(context).receiveTimeValue.toString() +
          "GGGF");
      print(BlocProvider.of<SearchCubit>(context).receiveDateValue.toString() +
          "GGG");
      print(BlocProvider.of<SearchCubit>(context).driveDateValue.toString() +
          "HHH");
      // print(BlocProvider.of<SearchCubit>(context).selectedRegion.toString()+"GGG");
      // print(BlocProvider.of<SearchCubit>(context).selectedDriveBranch.toString()+"fff");
      if (BlocProvider.of<ProfileCubit>(context).custClass == '1'.toString()) {
        setState(() {
          searchError = false;
        });
      }
      if (BlocProvider.of<SearchCubit>(context).selectedRegion == null ||
          BlocProvider.of<SearchCubit>(context).selectedReceiveBranch == null) {
        setState(() {
          searchError = true;
        });
      } else {
        setState(() {
          searchError = false;
        });
      }
      final triggeredBranchModel = context
          .read<SearchCubit>()
          .branchesData
          .where((element) =>
              element.name ==
              BlocProvider.of<SearchCubit>(context).selectedReceiveBranch)
          .first;
      BlocProvider.of<SearchCubit>(context).selectedReceiveModel =
          triggeredBranchModel;
      // drive
      if (BlocProvider.of<SearchCubit>(context).selectedDriveBranch != null) {
        final triggeredDriveBranchModel = context
            .read<AllBranchCubit>()
            .branchesData
            .where((element) =>
                element.name ==
                BlocProvider.of<SearchCubit>(context).selectedDriveBranch)
            .first;
        BlocProvider.of<SearchCubit>(context).selectedDriveModel =
            triggeredDriveBranchModel;
      } else {
        BlocProvider.of<SearchCubit>(context).selectedDriveModel =
            triggeredBranchModel;
        print(BlocProvider.of<SearchCubit>(context).selectedDriveBranch);
      }

      // Validation
      await BlocProvider.of<SearchCubit>(context).validate();
    } catch (e) {
      setState(() {
        searchError = true;
      });
    }
  }

  SizedBox? listViewHorizantal(
    Size size,
    locale,
    String state,
    String stateText,
    String pickUpBranch,
    String pickUpDate,
    String droppOffDate,
    String droOffBranch,
  ) {
    return
        //stateText=='اكتمل'||stateText =='done'||stateText=='في الانتظار'||stateText=='pending'||stateText=='في الانتظار'||stateText=='pending'?
        SizedBox(
      child: Card(
        color: Colors.transparent,
        elevation: 0.0,
        margin: const EdgeInsets.symmetric(horizontal: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18.sp)))),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  right: BorderSide(color: Color(0xff5D6FD4), width: 6),
                  bottom: BorderSide(color: Color(0xff5D6FD4), width: 1.2),
                )),
            child: Container(
              height: size.height * 0.18,
              width: size.width / 1.2,
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xff323376)
                      : Color(0XFFCAD3F3),
                  border: Border(
                    right: BorderSide(
                        color: Theme.of(context).brightness == Brightness.light
                            ? kPrimaryColor.withOpacity(0.3)
                            : Color(0xff505AC9),
                        width: 5),
                  )),
              child: Row(
                children: [
                  ///------First
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.sp,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.01),
                          child: Stack(
                            children: [
                              Container(
                                width: size.width * 0.19,
                                height: size.height * 0.035,
                                decoration: BoxDecoration(
                                    color: stateText == 'اكتمل' ||
                                            stateText == 'done'
                                        ? Colors.green.withOpacity(0.3)
                                        : stateText == 'في الانتظار' ||
                                                stateText == 'pending'
                                            ? Color(0xffE5BFF2)
                                            : stateText == 'مؤكد' ||
                                                    stateText == 'confirmed'
                                                ? Color(0xffCBE5E1)
                                                : Color(0xffDD5406),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Center(
                                  child: Text(
                                    stateText.toString(),
                                    style: defaultTextStyle(
                                      14,
                                      FontWeight.w500,
                                      stateText == 'اكتمل' ||
                                              stateText == 'done'
                                          ? Colors.green
                                          : stateText == 'في الانتظار' ||
                                                  stateText == 'pending'
                                              ? Color(0xff8304B0)
                                              : stateText == 'مؤكد' ||
                                                      stateText == 'confirmed'
                                                  ? Color(0xff1FA88F)
                                                  : Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.height * 0.05,
                          ),
                          child: Text(
                            locale.pickUpBranch,
                            style: defaultTextStyle(
                                12,
                                FontWeight.w400,
                                Theme.of(context).brightness == Brightness.light
                                    ? Color(0xff819D91)
                                    : Color(0xffF08A61)),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.002,
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Icon(Icons.location_on_outlined,
                                  color: kPrimaryColor, size: 20),
                              Text(
                                pickUpBranch,
                                overflow: TextOverflow.ellipsis,
                                style: defaultTextStyle(
                                    13,
                                    FontWeight.w400,
                                    Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Color(0xff5D5F5E)
                                        : Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.height * 0.01,
                          ),
                          child: Text(
                            pickUpDate,
                            overflow: TextOverflow.ellipsis,
                            style: defaultTextStyle(
                                12,
                                FontWeight.w400,
                                Theme.of(context).brightness == Brightness.light
                                    ? Color(0xff5D5F5E)
                                    : Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///--------second
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.13,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            locale.dropOffBranch,
                            overflow: TextOverflow.ellipsis,
                            style: defaultTextStyle(
                                12,
                                FontWeight.w400,
                                Theme.of(context).brightness == Brightness.light
                                    ? Color(0xff819D91)
                                    : Color(0xffF08A61)),
                          ),
                        ),
                        // SizedBox(height: MediaQuery.of(context).size.height*0.008,),
                        FittedBox(
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Icon(
                                  Icons.gps_fixed_outlined,
                                  color: KSecondColor,
                                  size: 20,
                                ),
                              ),
                              Text(droOffBranch,
                                  overflow: TextOverflow.ellipsis,
                                  style: defaultTextStyle(
                                    13,
                                    FontWeight.w400,
                                    Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Color(0xff5D5F5E)
                                        : Colors.white,
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.height * 0.03,
                          ),
                          child: Text(
                            droppOffDate,
                            overflow: TextOverflow.ellipsis,
                            style: defaultTextStyle(
                                13,
                                FontWeight.w400,
                                Theme.of(context).brightness == Brightness.light
                                    ? Color(0xff5D5F5E)
                                    : Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget whenCardsEmpty(size, locale) {
    return Container(
      height: size.height * 0.15,
      width: size.width * 0.88,
      decoration: BoxDecoration(
          color: Color(0XFFCAD3F3), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.sp,
                ),
                Text(
                  locale.reserveYourCarNow.toString(),
                  style: defaultTextStyle(22, FontWeight.w600, kPrimaryColor),
                ),
                Text(locale.knowAboutFleet.toString(),
                    style:
                        defaultTextStyle(14, FontWeight.w500, Colors.black54)),
              ],
            ),
          ),
          Expanded(
            child: SvgPicture.asset(
              'assets/images/Calendares.svg',
            ),
          ),
        ],
      ),
    );
  }
}
