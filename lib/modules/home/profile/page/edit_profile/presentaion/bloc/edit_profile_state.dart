import 'package:equatable/equatable.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

// Edit Profile
class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileLoaded extends EditProfileState {}

class EditProfileError extends EditProfileState {
  final String error;

  EditProfileError(this.error);
  @override
  List<Object> get props => [error];
}

//upload image
class ImageProfileLodingState extends EditProfileState {}

class ImageProfileScussesState extends EditProfileState {}

class ImageProfileErrorState extends EditProfileState {
  final String error;

  ImageProfileErrorState({
    required this.error,
  });
}
///upload imageLicence
class ImageLicenceLoadingState extends EditProfileState {}

class ImageLicenceLSuccessState extends EditProfileState {}

class ImageLicenceLErrorState extends EditProfileState {
  final String error;

  ImageLicenceLErrorState({
    required this.error,
  });
}
