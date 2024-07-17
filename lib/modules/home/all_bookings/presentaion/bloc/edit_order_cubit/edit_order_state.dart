part of 'edit_order_cubit.dart';

abstract class EditOrderState extends Equatable {
  const EditOrderState();

  @override
  List<Object> get props => [];
}

class EditOrderInitial extends EditOrderState {}

class EditOrderLoading extends EditOrderState {}

class EditOrderSuccess extends EditOrderState {}

class EditOrderFailed extends EditOrderState {
  final String error;

  EditOrderFailed(this.error);

  @override
  List<Object> get props => [error];
}
