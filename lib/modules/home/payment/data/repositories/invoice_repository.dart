import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:abudiyab/modules/home/payment/data/datasources/remote/invoice_remote_datasource.dart';
import 'package:abudiyab/modules/home/payment/data/models/automated_invoice_model.dart';
import 'package:abudiyab/modules/home/payment/data/models/invoice_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/booking_cubit/booking_cubit.dart';
import '../models/credit_card_model.dart';

class InvoiceRepository {
  final InvoiceRemoteDatasource invoiceRemoteDatasource;
  final SharedPreferencesHelper preferencesHelper;

  InvoiceRepository(this.invoiceRemoteDatasource, this.preferencesHelper);

  Future<InvoiceModel> getInvoice({
    String? languageCode,
    required String orderID,
    required List<int> additions,
    required String paymentType,
    context,
  }) async {
    final userToken = await preferencesHelper.getToken();
    final invoice = await invoiceRemoteDatasource.getInvoice(
      token: userToken.toString(),
      orderID: orderID,
      additions: additions,
      paymentType:paymentType,
      languageCode: languageCode,
    );
    return invoice;
  }

  Future<AutomatedInvoiceModel> getAutomatedInvoice({
    String? languageCode,
    required String orderID,
    required List<int> additions,
  }) async {
    final userToken = await preferencesHelper.getToken();
    final invoice = await invoiceRemoteDatasource.getAutomatedInvoice(
      token: userToken.toString(),
      orderID: orderID,
      additions: additions,
      languageCode: languageCode,
    );
    return invoice;
  }
}
