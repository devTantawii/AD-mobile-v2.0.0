import 'package:abudiyab/modules/home/profile/page/all_member_ship/model/all_member_model.dart';
import 'package:equatable/equatable.dart';

abstract class AllMemberState extends Equatable {
  const AllMemberState();
  @override
  List<Object> get props => [];
}

class AllMemberInitial extends AllMemberState {}

class AllMemberLoading extends AllMemberState {}

class AllMemberLoaded extends AllMemberState {
  final AllMember allMember;
  const AllMemberLoaded({required this.allMember});
  @override
  List<Object> get props => [allMember];
}

class AllMemberError extends AllMemberState {
  final String error;
  const AllMemberError({required this.error});
  @override
  List<Object> get props => [error];
}
