import 'package:abudiyab/core/helpers/enums.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/all_bookings/data/model/booking_automation_model.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_cubit.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/regions_model.dart';
import 'package:abudiyab/modules/widgets/components/custom_rect_tween.dart';
import 'package:abudiyab/modules/widgets/components/hero_dialog_route.dart';
import 'package:abudiyab/shared/style/colors.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RegionTile extends StatefulWidget {
  final List<RegionModel>? regions;

  const RegionTile({
    Key? key,
    required this.regions,
  }) : super(key: key);

  @override
  State<RegionTile> createState() => _RegionTileState();
}

class _RegionTileState extends State<RegionTile> {
  List<bool> _isTappedList = [];
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () {
        customeDialog(context, regionModel: widget.regions!.toList(), receive: true);
      },
      child: Hero(
        tag: _heroTag,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: Container(
          width: MediaQuery.of(context).size.width*0.9,
          height: 54.h,
          //padding: const EdgeInsets.all(10),
          alignment: AlignmentDirectional.bottomStart,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.withOpacity(0.15),
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.03),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: SvgPicture.asset('assets/images/locatt.svg')),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: Text(
                      BlocProvider.of<SearchCubit>(context).selectedRegion ??
                          locale!.selectRegion.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 15.sp
                      )

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

  Future<dynamic> customeDialog(BuildContext context,
      {required List<RegionModel> regionModel, required bool receive}) {
    final local = AppLocalizations.of(context);

    return showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.background,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.23,
                  height: MediaQuery.of(context).size.height * 0.008,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              Row(
                children: [
                  Text(
                    local!.selectRegion.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.008,
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 3),
                  crossAxisCount: 3,
                  crossAxisSpacing: 3.0.sp,
                  mainAxisSpacing: 7.0.sp,
                ),
                itemCount: widget.regions!.length.toInt(),
                itemBuilder:
                    (context, index) {
                  if (_isTappedList.length <= index) {
                    _isTappedList.add(false);
                  }
                      return GestureDetector(
                        onTap: () {
                          // setState(() {
                          //   _isTappedList[index] = !_isTappedList[index];
                          // });
                          BlocProvider.of<SearchCubit>(context).selectedRegion =
                          widget.regions![index].name;
                          final selectedRegionModel =
                              BlocProvider.of<SearchCubit>(context)
                                  .regionsData
                                  ?.where((element) =>
                              element.name ==
                                  BlocProvider.of<SearchCubit>(context)
                                      .selectedRegion)
                                  .first;
                          BlocProvider.of<SearchCubit>(context).selectedReceiveBranch =
                          null;
                          BlocProvider.of<SearchCubit>(context).selectedDriveBranch =
                          null;
                          BlocProvider.of<SearchCubit>(context).rentType ==
                              RentType.classic

                              ? BlocProvider.of<SearchCubit>(context).getBranches(regionId: selectedRegionModel?.id)
                              : BlocProvider.of<SearchCubit>(context).getAreas(regionId: selectedRegionModel?.id);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            // color: _isTappedList[index] ? Colors.red : Colors.blue,
                            color: Theme.of(context).brightness==Brightness.light?Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5):Color(0xffFDFDFD).withOpacity(0.1),
                            borderRadius:BorderRadius.circular(8),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/images/areaLocations.svg',color: Theme.of(context).brightness ==Brightness.light?Color(0xFF505AC9):Colors.white,),
                                // SvgPicture.asset('assets/images/dark-imagesareaLocations.svg'),
                                Flexible(
                                  child: Text(
                                    widget.regions![index].name.toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color:Theme.of(context).brightness ==Brightness.light?Colors.black:Colors.white),
                                  ),
                                ),
                              ]),
                        ),
                      );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const String _heroTag = 'Hero-Tag';

class _PopupCard extends StatefulWidget {
  final List<RegionModel>? regions;

  const _PopupCard({Key? key, required this.regions}) : super(key: key);

  @override
  State<_PopupCard> createState() => _PopupCardState();
}

class _PopupCardState extends State<_PopupCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroTag,
          createRectTween: (begin, end) =>
              CustomRectTween(begin: begin!, end: end!),
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...widget.regions!
                        .map(
                          (region) => SelectionTile(
                          text: region.name ?? "",
                          onTap: () {
                            setState(() =>
                            BlocProvider.of<SearchCubit>(context)
                                .selectedRegion = region.name);
                            final selectedRegionModel =
                                BlocProvider.of<SearchCubit>(context)
                                    .regionsData
                                    ?.where((element) =>
                                element.name ==
                                    BlocProvider.of<SearchCubit>(
                                        context)
                                        .selectedRegion)
                                    .first;
                            BlocProvider.of<SearchCubit>(context)
                                .selectedReceiveBranch = null;
                            BlocProvider.of<SearchCubit>(context)
                                .selectedDriveBranch = null;
                            BlocProvider.of<SearchCubit>(context)
                                .rentType ==
                                RentType.classic
                                ? BlocProvider.of<SearchCubit>(context)
                                .getBranches(
                                regionId: selectedRegionModel?.id)
                                : BlocProvider.of<SearchCubit>(context)
                                .getAreas(
                                regionId: selectedRegionModel?.id);
                            Navigator.pop(context);
                          }),
                    )
                        .toList(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectionTile extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const SelectionTile({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextButton(
          onPressed: onTap,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 15.sp,
            ),
          )),
    );
  }
}
