import 'package:abudiyab/modules/home/all_branching/data/models/branch_model.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/areas_model.dart';
import 'package:flutter/material.dart';

import 'areas_list_view.dart';
import 'branches_list_view.dart';

class LocationListView extends StatelessWidget {
  final List<BranchModel> branches;
  final bool isReceive;
  final bool isAutomated;
  final List<AreasModel>? areas;

  LocationListView(
      {Key? key,
      required this.branches,
      required this.isReceive,
      required this.isAutomated,
      this.areas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only(left: 10, right: 10,),
      // color: Theme.of(context).scaffoldBackgroundColor,
      child: isAutomated
          ? AreasListView(areas: areas, isReceive: isReceive)
          : BranchesListView(branches: branches, isReceive: isReceive),
    );
  }
}
