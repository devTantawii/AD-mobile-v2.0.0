import 'dart:developer';

import 'package:abudiyab/modules/home/profile/data/models/profile_model.dart';
import 'package:abudiyab/modules/home/profile/page/edit_profile/datasources/remote/edit_remote_dataSource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.editProfileDataSource) : super(EditProfileInitial());
  static EditProfileCubit get(context) => BlocProvider.of(context);

  final EditProfileDataSource editProfileDataSource;

  //uplod Image
  var picker = ImagePicker();
  XFile? imageProfile;
  String imagePathFace = "";
  void getImage() async {
    emit(ImageProfileLodingState());

    imageProfile =
        await picker.pickImage(source: ImageSource.gallery).then((value) async {
      imagePathFace = value!.path;

      print(imagePathFace);

      emit(ImageProfileScussesState());
    }).catchError((e) {
      emit(ImageProfileErrorState(error: e.toString()));
    });
  }
  ///uplod Licence Image
  var pickerLicence = ImagePicker();
  XFile? imageProfileLicence;
  String imagePathFaceLicence = "";

  void getImageLicence() async {
    emit(ImageLicenceLoadingState());

    imageProfileLicence =
    await pickerLicence.pickImage(source: ImageSource.gallery).then((value) async {
      imagePathFaceLicence = value!.path;
      print(imagePathFaceLicence);
      emit(ImageLicenceLSuccessState());
    }).catchError((e) {
      emit(ImageLicenceLErrorState(error: e.toString()));
    });
  }
  ///-------------End-----------

//Edit Profile
  Future editProfile({
    required String image,
    required String name,
    required String email,
    required String phone,
    required ProfileModel profileModel,
    required String licenceFace,
  }) async {
    emit(EditProfileLoading());
    try {
      await editProfileDataSource
          .editProfile(
          image: image == "" ? "" : image,
          licenceImage : licenceFace == "" ? "" : licenceFace,
          data: {
        "name": name == "" ? profileModel.name! : name,
        "email": email == "" ? profileModel.email! : email,
        "phone": phone == "" ? profileModel.phone! : phone,
      });
      emit(EditProfileLoaded());
      print("Hammad " + licenceFace.toString());

    } catch (e) {
      log(e.toString());
      emit(EditProfileError(e.toString()));
    }
  }
}
