import 'package:abudiyab/core/constants/assets/assets.dart';
import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/all_branching/bloc/all_branching_cubit.dart';
import 'package:abudiyab/modules/home/all_branching/bloc/all_branching_state.dart';
import 'package:abudiyab/modules/home/all_branching/page/view_location.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../../shared/style/colors.dart';
import 'text_tile_branch.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({Key? key}) : super(key: key);

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllBranchCubit>(context).getAllBranch();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          locale!.branches.toString(),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20.sp,fontWeight: FontWeight.w600),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => BlocProvider.of<AllBranchCubit>(context)
            .getAllBranch(pageNumber: 1),
        child: BlocConsumer<AllBranchCubit, AllBranchState>(
          listener: (context, state) {
            if (state is AllBranchError) {
              HelperFunctions.showFlashBar(
                  context: context,
                  title: "",
                  message: state.error,
                  icon: Icons.warning_amber,
                  color: Color(0xffF6A9A9),
                  titlcolor: Colors.red,
                  iconColor: Colors.red
              );
            }
          },
          builder: (context, state) {
            if (state is AllBranchLoading) {
              return Center(child: CircularProgressIndicator.adaptive(backgroundColor: Theme.of(context).colorScheme.onPrimary,));
            }
            if (state is AllBranchLoaded) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: state.branchModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: size.height * 0.012,
                      right: size.width*0.03,
                      left: size.width*0.03,
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.03, vertical: size.height * 0.011),
                    height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: Theme.of(context).brightness==Brightness.light?BorderRadius.circular(8):BorderRadius.circular(8),
                          color: Theme.of(context).brightness==Brightness.light?Color(0xffF4F4F6):null,
                          border: Border.all(
                              color: Theme.of(context).brightness==Brightness.dark?Color(0xff505AC9):Colors.transparent
                          )
                      ),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.015,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(Assets.icon_roundLocation,),
                                    Expanded(
                                      child: AutoSizeText(
                                        " ${state.branchModel[index].name} ",
                                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                          overflow: TextOverflow.ellipsis,
                                        ),),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.18,
                                  child: IconButton(
                                      onPressed: () {
                                        UrlLauncher.launchUrl(
                                             Uri(scheme: 'tel', path: state.branchModel[index].phone));
                                      },
                                      icon: SvgPicture.asset(
                                        Assets.icon_arabicCall,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              pushNewScreen(context,
                                  screen: ViewLocation(
                                    title: "${state.branchModel[index].name}",
                                    url: state.branchModel[index].locationUrl,
                                  ));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.sp,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: FittedBox(
                                      fit: BoxFit.none,
                                      alignment: locale.isDirectionRTL(context) ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        // mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.location_pin,size: 18,color: kButtonColor,),
                                              FittedBox(
                                                child: TextTileBranch(
                                                  content: "${state.branchModel[index].region}",
                                                  title: "${locale.region.toString()} :",
                                                  size: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.015,
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.location_pin,size: 18,color: kButtonColor,),
                                              FittedBox(
                                                child: TextTileBranch(
                                                  content:
                                                      "${state.branchModel[index].address}",
                                                  title:
                                                      "${locale.address.toString()} :",
                                                  size: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.015,
                                          ),
                                          state.branchModel[index].workTime!
                                                      .openAllDays ==
                                                  "1"
                                              ? Row(
                                                children: [
                                                  Icon(Icons.watch_later,size: 18,color: kButtonColor,),
                                                  FittedBox(
                                                      child: TextTileBranch(
                                                        content:
                                                            "24  ${locale.hour}",
                                                        title:
                                                            "${locale.workTime} :",
                                                        size: 10,
                                                      ),
                                                    ),
                                                ],
                                              )
                                              : SizedBox.shrink(),
                                          state.branchModel[index].workTime!
                                                      .openAllDays ==
                                                  "1"
                                              ? SizedBox.shrink()
                                              : Row(
                                                children: [
                                                  Icon(Icons.watch_later,size: 18,color: kButtonColor,),
                                                  FittedBox(
                                                      child: TextTileBranch(
                                                        content:
                                                            "${state.branchModel[index].workTime!.alldays!.morning!.timeopen} ${' - '} ${state.branchModel[index].workTime!.alldays!.morning!.timeclose} ",
                                                        title:
                                                            "${locale.morning.toString()} :",
                                                        size: 10,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.025,
                                          ),
                                          state.branchModel[index].workTime!
                                                          .openAllDays ==
                                                      "1" ||
                                                  state.branchModel[index]
                                                          .workTime!
                                                          .alldays!
                                                          .period ==
                                                      '0'
                                              ? SizedBox.shrink()
                                              : Row(
                                                children: [
                                                  Icon(Icons.watch_later,size: 18,color: kButtonColor,),
                                                  FittedBox(
                                                      child: TextTileBranch(
                                                        content:
                                                            "${state.branchModel[index].workTime!.alldays!.afternone!.timeopen} ${locale.toTime} ${state.branchModel[index].workTime!.alldays!.morning!.timeclose} ",
                                                        title:
                                                            "${locale.afternoon.toString()} :",
                                                        size: 10.sp,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                locale.openLocation.toString(),
                                                style: defaultTextStyle(14,FontWeight.w600 , KSecondColor),
                                              ),
                                              Text('  '),
                                              Icon(Icons.arrow_forward_ios_rounded,size: 16,color: KSecondColor,),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.015,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
