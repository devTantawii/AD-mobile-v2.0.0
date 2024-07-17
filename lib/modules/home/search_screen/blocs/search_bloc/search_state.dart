import 'package:abudiyab/modules/home/all_branching/data/models/branch_model.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/areas_model.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/offers_model.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/regions_model.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<BranchModel> branches;

  SearchSuccess(this.branches);

  @override
  List<Object> get props => [branches];
}

class GetAreaSuccess extends SearchState {
  final List<AreasModel> branches;

  GetAreaSuccess(this.branches);

  @override
  List<Object> get props => [branches];
}

class SearchFailed extends SearchState {
  final String error;

  SearchFailed(this.error);

  @override
  List<Object> get props => [error];
}

class SearchCheckLoading extends SearchState {}

class SearchValidate extends SearchState {
  final String message;

  SearchValidate(this.message);

  @override
  List<Object> get props => [message];
}

class SearchInvalid extends SearchState {
  final String message;

  SearchInvalid(this.message);

  @override
  List<Object> get props => [message];
}

class RegionsSuccess extends SearchState {
  final List<RegionModel>? regions;

  RegionsSuccess(this.regions);

  @override
  List<Object> get props => [regions ?? []];
}
class OffersLoding extends SearchState {

}

class OffersLoded extends SearchState {
  final OffersModel offersModel;
  OffersLoded(this.offersModel);

  @override
  List<Object> get props => [OffersModel];
}

class OffersErorr extends SearchState {
  final String message;
  OffersErorr(this.message);
  // @override
  // List<Object> get props => [message];
}
