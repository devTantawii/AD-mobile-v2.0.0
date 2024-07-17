part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileModel profileModel;

  ProfileSuccess(this.profileModel);

  @override
  List<Object> get props => [profileModel];
}

class ProfileFailed extends ProfileState {
  final String? error;

  ProfileFailed(this.error);

  @override
  List<Object> get props => [error ?? ""];
}
///Delete states
class DeleteProfileLoading extends ProfileState {}

class DeleteProfileSuccess extends ProfileState {
  final DeleteProfileModel deleteProfileModel;

  DeleteProfileSuccess(this.deleteProfileModel);

  // @override
  // List<Object> get props => [deleteProfileModel];
}

class DeleteProfileFailed extends ProfileState {
  final String? error;

  DeleteProfileFailed(this.error);

  // @override
  // List<Object> get props => [error ?? ""];
}
class ProfileLogout extends ProfileState {}

