part of 'additions_cubit.dart';

abstract class AdditionsState extends Equatable {
  const AdditionsState();

  @override
  List<Object> get props => [];
}

class AdditionsInitial extends AdditionsState {}
class AdditionsInit extends AdditionsState {}

class AdditionsLoading extends AdditionsState {}

class AdditionsSuccess extends AdditionsState {
  final List<Feature?>? features;

  AdditionsSuccess(this.features);

  @override
  List<Object> get props => [features ?? []];
}

class AdditionsFailed extends AdditionsState {
  final String error;

  AdditionsFailed(this.error);

  @override
  List<Object> get props => [error];
}
class AdditionsNotCompletedLoading extends AdditionsState {}

class AdditionsNotCompletedSuccess extends AdditionsState {
  final List<Features?>? features;

  AdditionsNotCompletedSuccess(this.features);

  @override
  List<Object> get props => [features ?? []];
}
class CheckOrderStateLoading extends AdditionsState {}

class CheckOrderStateSuccess extends AdditionsState {
  final CheckOrderStepModel stepModel;
  CheckOrderStateSuccess({required this.stepModel});
  @override
  List<Object> get props => [stepModel];

}
class CheckOrderStateLoaded extends AdditionsState {
  //  final List<Features> features;
  // CheckOrderStateLoaded({required this.features});
  // @override
  // List<Object> get props => [features];

}

class CheckOrderStateError extends AdditionsState {
  final String error;
  CheckOrderStateError({required this.error});
  @override
  List<Object> get props => [error];
}
class CheckAdditionLoading extends AdditionsState {}
class CheckAdditionSuccess extends AdditionsState {}
class CheckAdditionSelectedLoading extends AdditionsState {}
class CheckAdditionSelectedSuccess extends AdditionsState {}
