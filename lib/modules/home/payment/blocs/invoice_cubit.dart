import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:abudiyab/modules/home/additions/data/models/payment_step_model.dart';
import 'package:abudiyab/modules/home/additions/presentaion/blocs/addition_cubit/additions_cubit.dart';
import 'package:abudiyab/modules/home/all_bookings/data/model/booking_model.dart';
import 'package:abudiyab/modules/home/blocs/booking_cubit/booking_cubit.dart';
import 'package:abudiyab/modules/home/payment/data/models/automated_invoice_model.dart';
import 'package:abudiyab/modules/home/payment/data/models/credit_card_model.dart';
import 'package:abudiyab/modules/home/payment/data/models/invoice_model.dart';
import 'package:abudiyab/modules/home/payment/data/repositories/invoice_repository.dart';
import 'package:abudiyab/modules/home/payment/data/repositories/payment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final BookingCubit bookingCubit;
  final AdditionsCubit additionsCubit;
  final InvoiceRepository invoiceRepository;
  final PaymentRepository paymentRepository;

  InvoiceCubit(this.invoiceRepository, this.bookingCubit, this.additionsCubit,
      this.paymentRepository)
      : super(InvoiceInitial());

  InvoiceModel? data;
  Future getInvoice(context) async {
    emit(InvoiceLoading());
    try {
      data = await invoiceRepository.getInvoice(
          orderID: bookingCubit.orderID.toString(),
          additions: bookingCubit.additions ?? [],
          paymentType: BlocProvider.of<BookingCubit>(context).selectedPaymentMethods.toString()
        // cardModel:cardModel
      );
      emit(InvoiceSuccess(data!));
    } catch (error) {
      print(error.toString());
      emit(InvoiceFailed(error.toString()));
    }
  }

  Future getInvoiceNotCompletedOrder(context,dynamic orderId) async {
    emit(InvoiceLoading());
    try {
      data = await invoiceRepository.getInvoice(
          orderID: orderId.toString(),
          additions: bookingCubit.additions ?? [],
          paymentType: BlocProvider.of<BookingCubit>(context).selectedPaymentMethods.toString()
        // cardModel:cardModel
      );
      emit(InvoiceSuccess(data!));
    } catch (error) {
      emit(InvoiceFailed(error.toString()));
    }
  }
  Future activePaymentStep(CreditCardModel? cardModel) async {
    emit(InvoiceLoading());
    try {
      final PaymentStepModel data =
      await paymentRepository.activePaymentStep(cardModel: cardModel);
      emit(PaymentSuccess(data));
    } catch (error) {
      emit(InvoiceFailed(error.toString()));
    }
  }

  Future<bool> checkOrder() async {
    try {
      final data =
      await paymentRepository.checkOrder(orderId: bookingCubit.orderID!);
      return data;
    } catch (error) {
      throw FetchDataException(data: "...Oops", details: error.toString());
    }
  }
}
