import 'package:abudiyab/modules/home/all_branching/data/models/branch_model.dart';
import 'package:equatable/equatable.dart';

abstract class AllBranchState extends Equatable {
  AllBranchState();
  @override
  List<Object> get props => [];
}

class AllBranchInitial extends AllBranchState {}

class AllBranchLoading extends AllBranchState {}

class AllBranchLoaded extends AllBranchState {
  final List<BranchModel> branchModel;
  AllBranchLoaded({required this.branchModel});
  @override
  List<Object> get props => [branchModel];
}

class AllBranchError extends AllBranchState {
  final String error;
  AllBranchError({required this.error});

  @override
  List<Object> get props => [error];
}
