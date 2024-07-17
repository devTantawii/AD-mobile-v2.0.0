import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:abudiyab/modules/home/profile/data/datasources/remote/profile_sevice.dart';
import 'package:abudiyab/modules/home/profile/data/models/delete_profile_model.dart';
import 'package:abudiyab/modules/home/profile/data/models/profile_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/datasources/remote/delete_profile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SharedPreferencesHelper sharedPreferencesHelper;

  ProfileCubit(this.sharedPreferencesHelper) : super(ProfileInitial());

  dynamic custClass;
  String? deleteStatus;
  String? licenceImage;

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final ProfileModel? userData = await ProfileService.getProfile(langCode);
      custClass = userData!.custClass.toString();
      licenceImage = userData.user_license.toString();
      deleteStatus = userData.deleteStatus.toString();
      emit(ProfileSuccess(userData));
    } catch (error) {
      emit(ProfileFailed(error.toString()));
    }
  }

  ///DELETE PROFILE

  int? code;

  Future<void> deleteProfile() async {
    emit(DeleteProfileLoading());
    try {
      final DeleteProfileModel? deleteProfileModel =
          await DeleteProfileService.deleteProfile(langCode);
      code = deleteProfileModel!.code;
      print(code.toString());
      emit(DeleteProfileSuccess(deleteProfileModel));
    } catch (error) {
      emit(DeleteProfileFailed(error.toString()));
    }
  }

  logOut() async {
    await sharedPreferencesHelper.clear('token').then((value) => userToken = "");

    emit(ProfileLogout());
  }
}
