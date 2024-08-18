import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/all_branching/data/models/branch_model.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/areas_model.dart';
import 'package:abudiyab/modules/home/search_screen/presentaion/widget/location_list_view.dart';
import 'package:abudiyab/modules/home/search_screen/presentaion/widget/location_map.dart';
import 'package:abudiyab/modules/home/search_screen/presentaion/widget/map_list_tapbar.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MapListView extends StatefulWidget {
  final List<BranchModel>? branches;
  final bool isReceive;
  final List<AreasModel>? areas;
  final bool isAutomated;

  const MapListView(
      {Key? key,
      required this.branches,
      required this.isReceive,
      required this.areas,
      required this.isAutomated})
      : super(key: key);

  @override
  State<MapListView> createState() => _MapListViewState();
}

class _MapListViewState extends State<MapListView>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  bool isMap = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(locale!.selectBranch.toString(),style: defaultTextStyle(20, FontWeight.w700,Theme.of(context).colorScheme.onPrimary),),
        leading: ADBackButton(),
      ),
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: MapListTapBar(
                  controller: tabController,
                  isMap: (value) => setState(() => isMap = value),
                )),
                SizedBox(height: 15.h,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Container(
                //         width: size.width/2.5,
                //         decoration: BoxDecoration(
                //          borderRadius: BorderRadius.circular(4),
                //           border: Border.all(
                //             color: Theme.of(context).colorScheme.onPrimary
                //           )
                //         ),
                //         child:Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Icon(Icons.location_pin,size: 18,color: Theme.of(context).colorScheme.onPrimary,),
                //             FittedBox(
                //               child:Text(
                //                 "${BlocProvider.of<SearchCubit>(context).selectedRegion}",
                //                 style: TextStyle(
                //                     color: Theme.of(context).colorScheme.onPrimary,
                //                     fontSize: 14.sp
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Expanded(
                  flex: 12,
                  child: TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      LocationListView(
                        branches: widget.branches!,
                        isReceive: widget.isReceive,
                        isAutomated: widget.isAutomated,
                        areas: widget.areas,
                      ),
                      LocationMap(
                        branches: widget.branches,
                        isCircle: widget.isAutomated,
                        isMarker: !widget.isAutomated,
                        areas: widget.areas,
                        isReceive: widget.isReceive,
                      ),
                      // Reviews()
                    ],
                  ),
                ),

              ],
            ),
            //  ADPositionedBackButton(),
          ],
        ),
      ),
    );
  }
}
