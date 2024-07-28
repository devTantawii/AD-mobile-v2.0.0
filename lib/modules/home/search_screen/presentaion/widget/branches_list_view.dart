import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/all_branching/data/models/branch_model.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_cubit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../../../../../core/constants/assets/assets.dart';
import '../../../../../shared/commponents.dart';
import '../../../all_branching/bloc/all_branching_cubit.dart';
import '../../../all_branching/page/view_location.dart';

class BranchesListView extends StatefulWidget {
  final List<BranchModel> branches;
  final bool isReceive;

  const BranchesListView(
      {Key? key, required this.branches, required this.isReceive,})
      : super(key: key);

  @override
  State<BranchesListView> createState() => _BranchesListViewState();
}

class _BranchesListViewState extends State<BranchesListView> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context);
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        itemCount: widget.branches.length,
        itemBuilder: (context, index) {

          return InkWell(
            onTap: () {
              widget.isReceive
                  ? BlocProvider.of<SearchCubit>(context)
                      .selectedReceiveBranch = widget.branches[index].name
                  : BlocProvider.of<SearchCubit>(context).selectedDriveBranch =
                  context.read<AllBranchCubit>().branchesData[index].name;

              widget.isReceive
                  ?BlocProvider.of<SearchCubit>(context).selectedReceiveModel =
                  BlocProvider.of<SearchCubit>(context)
                      .branchesData
                      .where((element) => element.name == widget.branches[index].name)
                      .first
                  :BlocProvider.of<SearchCubit>(context).selectedReceiveModel =
                  context.read<AllBranchCubit>().branchesData
                      .where((element) => element.name == context.read<AllBranchCubit>().branchesData[index].name)
                      .first;
              BlocProvider.of<SearchCubit>(context).changeState();
              Navigator.pop(context);
            },
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.0.w,vertical: 5.h),
              child: Container(
                width: double.infinity,
                padding:  EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Branch Name + Icon + PHONE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(Assets.icon_roundLocation,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 3),
                              child: Container(
                                width: 200.w,
                                height: 45.h,
                                child: Text(
                                  " ${widget.branches[index].name.toString()}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: GestureDetector(
                            onTap: (){
                              UrlLauncher.launchUrl(
                                     Uri(scheme: 'tel', path: widget.branches[index].phone));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffFCE7D8),
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 8.0.w,vertical:3),
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.call,size: 15,color: Color(0xffF08A61),),
                                    Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Text(locale!.callUs.toString(),style: defaultTextStyle(12, FontWeight.w400, Color(0xffF08A61)),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                    /// END Branch Name + Icon + PHONE -------------
                    FittedBox(
                      child: Row(
                        children: [
                          Icon(Icons.location_pin,size: 16,color: Color(0xffCACACA),),
                           FittedBox(
                             child: Text(widget.branches[index].address.toString(),
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      // color: Color(0xff313131),
                                      fontSize: 14.sp,
                                )),
                           ),
                        ],
                      ),
                    ),

                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.watch_later,size: 18,color: Color(0xffCACACA),),
                            SizedBox(
                              width: size.width * 0.16,
                              child: AutoSizeText(" ${locale.allDays}: ",
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14.sp,

                                  )),
                            ),
                            AutoSizeText(
                                widget.branches[index]
                                    .workTime
                                    ?.alldays
                                    ?.morning
                                    ?.timeopen
                                    .toString() ??
                                    "",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14.sp
                                )),
                            AutoSizeText(" : "),
                            AutoSizeText(
                                widget.branches[index]
                                    .workTime
                                    ?.alldays
                                    ?.morning
                                    ?.timeclose
                                    .toString() ??
                                    "",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14.sp
                                )),
                            AutoSizeText(widget.branches[index]
                                .workTime
                                ?.alldays
                                ?.afternone
                                ?.timeopen ==
                                null
                                ? ""
                                : " - "),
                            AutoSizeText(
                                widget.branches[index]
                                    .workTime
                                    ?.alldays
                                    ?.afternone
                                    ?.timeopen ??
                                    " ",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(

                                    fontSize: 14.sp
                                )),
                            AutoSizeText(widget.branches[index]
                                .workTime
                                ?.alldays
                                ?.afternone
                                ?.timeclose ==
                                null
                                ? ""
                                : " : "),
                            AutoSizeText(
                                widget.branches[index]
                                    .workTime
                                    ?.alldays
                                    ?.afternone
                                    ?.timeclose ??
                                    "",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(

                                    fontSize: 14.sp
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.watch_later,size: 18,color: Color(0xffCACACA),),
                            SizedBox(
                              width: size.width * 0.16,
                              child: AutoSizeText("${locale.fri} :",
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 14.sp
                                  )),
                            ),
                            AutoSizeText(
                                widget.branches[index]
                                    .workTime
                                    ?.fri
                                    ?.morning
                                    ?.timeopen
                                    .toString() ??
                                    "",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(

                                    fontSize: 14.sp
                                )),
                            AutoSizeText(" : "),
                            AutoSizeText(
                                widget.branches[index]
                                    .workTime
                                    ?.fri
                                    ?.morning
                                    ?.timeclose
                                    .toString() ??
                                    "",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14.sp
                                )),
                          ],
                        ),
                      ],
                    ),


                    GestureDetector(
                      onTap: () {
                        pushNewScreen(context,
                            screen: ViewLocation(
                              title: "${widget.branches[index].name}",
                              url: widget.branches[index].locationUrl,
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: size.width*0.5,),
                          Text(
                            locale.openLocation.toString(),
                            style: Theme.of(context).textTheme.labelSmall),
                          Icon(Icons.arrow_forward_ios,color: Theme.of(context).colorScheme.onPrimary,size: 16,),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Divider(height: 2)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
