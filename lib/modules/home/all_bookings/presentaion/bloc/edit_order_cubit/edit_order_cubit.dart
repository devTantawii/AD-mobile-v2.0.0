import 'package:abudiyab/modules/home/all_bookings/data/datasources/edit_order_remote_datasource.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_order_state.dart';

class EditOrderCubit extends Cubit<EditOrderState> {
  final EditOrderRemoteDatasource editOrderRemoteDatasource;

  EditOrderCubit(this.editOrderRemoteDatasource) : super(EditOrderInitial());

  Future<void> editBooking({
    required int orderId,
    required String receivingId,
    required String deliveryId,
    required String receivingDate,
    required String deliveryDate,
  }) async {
    emit(EditOrderLoading());
    try {
      final msg = await editOrderRemoteDatasource.editBooking(
          orderId: orderId,
          receivingId: receivingId,
          deliveryId: deliveryId,
          receivingDate: receivingDate,
          deliveryDate: deliveryDate);

      if (msg == "order updated") {
        emit(EditOrderSuccess());
      } else if (msg != null) {
        emit(EditOrderFailed(msg.toString()));
      }
    } catch (e) {
      print(e.toString());
      emit(EditOrderFailed(e.toString()));
    }
  }
}
