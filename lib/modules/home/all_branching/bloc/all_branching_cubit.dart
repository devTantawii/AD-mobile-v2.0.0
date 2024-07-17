import 'package:abudiyab/modules/home/all_branching/bloc/all_branching_state.dart';
import 'package:abudiyab/modules/home/all_branching/data/all_branching_remote_datasource.dart';
import 'package:abudiyab/modules/home/all_branching/data/models/branch_model.dart';
import 'package:bloc/bloc.dart';

class AllBranchCubit extends Cubit<AllBranchState> {
  AllBranchCubit(this.allBranchRemoteDataSource) : super(AllBranchInitial());
  AllBranchRemoteDataSource allBranchRemoteDataSource;
  List<BranchModel> branchesData = [];

  Future<void> getAllBranch({int pageNumber = 1}) async {
    emit(AllBranchLoading());
    try {
      final data =
          await allBranchRemoteDataSource.getBranches(pageIndex: pageNumber);
      pageNumber == 1
          ? branchesData = data.data
          : branchesData.addAll(data.data);
      pageNumber++;
      emit(AllBranchLoaded(branchModel: branchesData));
      if (pageNumber <= 3) {
        getAllBranch(pageNumber: pageNumber);
      }
    } catch (e) {
      emit(
        AllBranchError(error: e.toString()),
      );
    }
  }
}
