
import 'package:abudiyab/modules/home/all_branching/data/models/branch_model.dart';

class FilterModel {
  final String? receiveTimeValue;
  final String? driveTimeValue;
  final BranchModel? selectedBranch;
  final String? receiveDateValue;
  final String? driveDateValue;

  FilterModel({
    this.receiveTimeValue,
    this.driveTimeValue,
    this.selectedBranch,
    this.receiveDateValue,
    this.driveDateValue,
  });

  factory FilterModel.fromMap(Map<String, dynamic> json) => FilterModel(
        receiveDateValue: json['receiveDateValue'],
        driveDateValue: json['driveDateValue'],
        receiveTimeValue: json["receiveTimeValue"],
        driveTimeValue: json['driveTimeValue'],
        selectedBranch: BranchModel.fromMap(json["selectedBranch"] as Map<String, dynamic>),
      );

  toJson() => {
        'receiveTimeValue': receiveTimeValue,
        'driveTimeValue': driveTimeValue,
        "receiveDateValue": receiveDateValue,
        "driveDateValue": driveDateValue,
        "selectedBranch": selectedBranch?.toMap(),
      };
}
