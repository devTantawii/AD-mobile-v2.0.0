import 'package:abudiyab/core/constants/assets/assets.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/all_branching/data/models/branch_model.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_cubit.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/areas_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../map_list_view.dart';

class MapListSelectionViewTile extends StatelessWidget {
  final List<BranchModel>? branches;
  final List<AreasModel>? areas;
  final bool isReceive;
  final bool isAutomated;
  final bool isDisabled;

  const MapListSelectionViewTile({
    Key? key,
    required this.branches,
    required this.isReceive,
    required this.areas,
    required this.isAutomated,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: isDisabled
          ? () {}
          : () {
              if (isAutomated || branches != null){
                pushNewScreen(context,
                    screen: MapListView(
                      isAutomated: isAutomated,
                      areas: areas,
                      branches: branches,
                      isReceive: isReceive,
                    ),
                    withNavBar: false);
              }
            },
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.03),
        child: Container(
          width: MediaQuery.of(context).size.width*0.9,
          height: 54.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.sp),
            color: Colors.grey.withOpacity(0.15),

          ),


            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                       isReceive?
                       SvgPicture.asset(Assets.icon_picker):SvgPicture.asset(Assets.icon_drop),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
                        child: Container(
                          width:MediaQuery.of(context).size.width*0.6,
                          child: Text(
                              isAutomated
                                  ? isReceive
                                      ? BlocProvider.of<SearchCubit>(context)
                                              .selectedReceiveArea ??
                                          locale.pickUpArea.toString()
                                      : BlocProvider.of<SearchCubit>(context)
                                              .selectedDriveArea ??
                                          locale.dropOffArea.toString()
                                  : isReceive
                                      ? BlocProvider.of<SearchCubit>(context)
                                              .selectedReceiveBranch ??
                                          locale.pickUpBranch.toString()
                                      : BlocProvider.of<SearchCubit>(context)
                                              .selectedDriveBranch ??
                                          locale.dropOffBranch.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 15.sp
                              )),
                        ),
                      ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_outlined,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )
                ],
              ),
            ),
          
        ),
      ),
    );
  }
}
