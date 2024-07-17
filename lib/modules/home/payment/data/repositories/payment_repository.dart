import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:abudiyab/modules/home/additions/data/models/payment_step_model.dart';
import 'package:abudiyab/modules/home/payment/data/datasources/remote/payment_remote_datasource.dart';
import 'package:abudiyab/modules/home/payment/data/models/credit_card_model.dart';

class PaymentRepository {
  final PaymentRemoteDatasource paymentRemoteDatasource;
  final SharedPreferencesHelper preferencesHelper;

  PaymentRepository(this.paymentRemoteDatasource, this.preferencesHelper);

  Future<PaymentStepModel> activePaymentStep(
      {required CreditCardModel? cardModel}) async {
    try {
      final userToken = await preferencesHelper.getToken() ?? "";
      final response = await paymentRemoteDatasource.activePaymentStep(
          token: userToken, cardModel: cardModel,
      );

      return response;
    } catch (error) {
      throw '..Oops $error';
    }
  }

  Future<PaymentStepModel> activeAutomatedPaymentStep(
      {required CreditCardModel? cardModel}) async {
    try {
      final userToken = await preferencesHelper.getToken() ?? "";
      final response = await paymentRemoteDatasource.activeAutomatedPaymentStep(
          token: userToken, cardModel: cardModel);
      return response;
    } catch (error) {
      throw '..Oops $error';
    }
  }

  Future<bool> checkOrder({required int orderId}) async {
    try {
      final userToken = await preferencesHelper.getToken() ?? "";
      final response = await paymentRemoteDatasource.checkOrderStatus(
          token: userToken,
          orderId: orderId);
      print("Hammad29");
      return response;
    } catch (error) {
      throw error;
    }
  }
}
