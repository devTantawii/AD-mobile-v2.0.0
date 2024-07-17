import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/date_helper.dart';
import 'package:abudiyab/core/helpers/enums.dart';
import 'package:abudiyab/modules/home/all_branching/data/models/branch_model.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_state.dart';
import 'package:abudiyab/modules/home/search_screen/data/datasources/remote/areas_remote_datasource.dart';
import 'package:abudiyab/modules/home/search_screen/data/datasources/remote/branchs_service.dart';
import 'package:abudiyab/modules/home/search_screen/data/datasources/remote/check_date_remote.dart';
import 'package:abudiyab/modules/home/search_screen/data/datasources/remote/regions_remote_datasource.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/areas_model.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/offers_model.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/regions_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/remote/offers_remte_datasource.dart';

class SearchCubit extends Cubit<SearchState> {
  final DateCheckerRemote dateCheckerRemote;
  final RegionsRemoteDatasource regionsRemoteDatasource;
  final AreasRemoteDatasource areasRemoteDatasource;

  SearchCubit(this.dateCheckerRemote, this.regionsRemoteDatasource,
      this.areasRemoteDatasource)
      : super(SearchInitial());
  static SearchCubit get(context)=> BlocProvider.of(context);
  RentType rentType = RentType.classic;
  bool isAutomated() => rentType == RentType.automated;

  String? selectedReceiveBranch;
  String? selectedDriveBranch;
  String? selectedRegion;

  String? selectedReceiveArea;
  String? selectedDriveArea;

  late DateTime receiveDateValue = DateTime.now();
  late DateTime driveDateValue = DateTime.now();

  late TimeOfDay receiveTimeValue = TimeOfDay.now();
  late TimeOfDay driveTimeValue = TimeOfDay.now();

  RegionModel? selectedRegionModel;
  BranchModel? selectedReceiveModel;
  BranchModel? selectedDriveModel;

  AreasModel? selectedAreaReceiveModel;
  AreasModel? selectedAreaDriveModel;

  List<RegionModel>? regionsData = [];
  List<BranchModel> branchesData = [];
  List<AreasModel>? areasData = [];

  getRegions() async {
    emit(SearchLoading());
    try {
      final regions = await regionsRemoteDatasource.getRegions();
      regionsData = regions;
      emit(RegionsSuccess(regions));
    } catch (error) {
      emit(SearchFailed(error.toString()));
    }
  }

  getAreas({int pageNumber = 1, int? regionId}) async {
    emit(SearchLoading());
    try {
      final areas = await areasRemoteDatasource.getAreas(
        pageIndex: pageNumber,
        regionId: regionId,
      );
      regionId != null ? areasData = areas : areasData?.addAll(areas);
      areasData = areas;
      pageNumber++;
      emit(GetAreaSuccess(areas));
      // if (pageNumber <= 3  ) {
      if (pageNumber <= 3 && regionId == null) {
        getAreas(pageNumber: pageNumber);
      }
    } catch (error) {
      emit(SearchFailed(error.toString()));
    }
  }

  Future getBranches({int pageNumber = 1, int? regionId}) async {
    emit(SearchLoading());
    try {
      final branches = await BranchesService.getBranches(
        pageIndex: pageNumber,
        regionId: regionId,
      );
      regionId != null
          ? branchesData = branches
          : branchesData.addAll(branches);
      pageNumber++;
      emit(SearchSuccess(branches));
      if (pageNumber <= 3 && regionId == null) {
        getBranches(pageNumber: pageNumber);
      }
    } catch (error) {
      emit(SearchFailed(error.toString()));
    }
  }

  Future getAllBranches({int pageNumber = 1, int? regionId}) async {
    emit(SearchLoading());
    try {
      final branches = await BranchesService.getBranches(
        pageIndex: pageNumber,
      );
      regionId != null
          ? branchesData = branches
          : branchesData.addAll(branches);
      pageNumber++;
      emit(SearchSuccess(branches));
      if (pageNumber <= 3 && regionId == null) {
        getBranches(pageNumber: pageNumber);
      }
    } catch (error) {
      emit(SearchFailed(error.toString()));
    }
  }

  Future validate() async {
    emit(SearchCheckLoading());
    try {
      String receiveHour = DateHandler.timeOfDayToHour(receiveTimeValue);
      String deliveryHour = DateHandler.timeOfDayToHour(driveTimeValue);
      final response = await dateCheckerRemote.validate(
        receivingId: selectedReceiveModel!.id.toString(),
        deliveryId: selectedDriveModel?.id.toString() ?? selectedReceiveModel!.id.toString(),
        receivingDate: DateHandler.mixDateWithHours(receiveDateValue, receiveHour),
        deliveryDate: DateHandler.mixDateWithHours(driveDateValue, deliveryHour),
      );
      if (response == "success") {
        emit(SearchValidate(response));
      } else
        emit(SearchInvalid(response));
    } catch (error) {
      emit(SearchFailed(error.toString()));
    }
  }

  changeState() {
    emit(SearchLoading());
    emit(RegionsSuccess(regionsData));
  }

  ///Offers Methods
  OffersRemotDataSource? offersRemotDataSource;
  OffersModel? offersModel;
  String ? message;
  int ? discountValue ;

  Future<void>  getOffers() async {
    emit(OffersLoding());
    try {
      final OffersModel? offersModel = await OffersRemotDataSource.getOffers(langCode);
     message=  offersModel!.message.toString();
     print(message.toString());
      discountValue=  offersModel.discountValue;
      emit(OffersLoded(offersModel));
    } catch (e) {
      emit(OffersErorr(e.toString()));
    }
  }
}
