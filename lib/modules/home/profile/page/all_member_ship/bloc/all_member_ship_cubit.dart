import 'package:abudiyab/modules/home/profile/page/all_member_ship/data/all_member_ship_remot.dart';
import 'package:bloc/bloc.dart';

import 'all_member_ship_state.dart';

class AllMemberCubit extends Cubit<AllMemberState> {
  AllMemberCubit(this.allMemberShipRemoteDataSource)
      : super(AllMemberInitial());
  final AllMemberShipRemoteDataSource allMemberShipRemoteDataSource;
  Future<void> getAllMember() async {
    emit(AllMemberLoading());
    try {
      final data = await allMemberShipRemoteDataSource.getAllMemberShip();
      emit(AllMemberLoaded(allMember: data));
    } catch (e) {
      emit(AllMemberError(error: e.toString()));
    }
  }
}
