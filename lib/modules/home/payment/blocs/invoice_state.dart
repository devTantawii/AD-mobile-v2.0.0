part of 'invoice_cubit.dart';

abstract class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object> get props => [];
}

class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoiceSuccess extends InvoiceState {
  final InvoiceModel invoiceModel;


  InvoiceSuccess(this.invoiceModel);

  @override
  List<Object> get props => [];
}

class AutomatedInvoiceSuccess extends InvoiceState {
  final AutomatedInvoiceModel automatedInvoiceModel;

  AutomatedInvoiceSuccess(this.automatedInvoiceModel);

  @override
  List<Object> get props => [];
}

class InvoiceFailed extends InvoiceState {
  final String error;

  InvoiceFailed(this.error);

  @override
  List<Object> get props => [error];
}

class PaymentSuccess extends InvoiceState {
  final PaymentStepModel paymentStepModel;

  PaymentSuccess(this.paymentStepModel);

  @override
  List<Object> get props => [paymentStepModel];
}
